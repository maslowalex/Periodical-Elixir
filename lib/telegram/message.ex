defmodule Telegram.Bot.Message do
  use ExGram.Bot, name: :periodical

  alias Periodical.Jobs

  @avaliable_instruments ["clarinet", "oboe", "flute", "tuba"]

  def reply_for(msg, context) when msg in @avaliable_instruments do
    jobs_for = Jobs.get_jobs_for(msg) |> format_message

    answer(context, "Here some jobs for #{msg}, that I've found on musicalchairs.com")
    answer(context, jobs_for, [disable_web_page_preview: true])
  end

  def reply_for(text, context) do
    IO.inspect text
    answer(context, "Don't know what you mean.")
  end

  defp format_message(jobs) do
    jobs
    |> Enum.map(fn job ->
      """
      Position: #{job[:position]}
      Location: #{job[:location]}
      Link: #{job[:link]}
      """
    end)
    |> Enum.join("\n")
  end
end
