defmodule OpenAi.Completion do
  @moduledoc """
  Some test calling OpenAI API.
  """

  alias OpenAi.ApiHelpers
  alias OpenAi.Completion.Dtos.Request
  alias OpenAi.Completion.Dtos.Response
  alias OpenAi.Completion.Dtos.State

  @completion_type "text-davinci-003"

  @doc """
  Calls the OpenAI completion API.
  @param prompt The prompt that will be sent to the API for the completion.
  @param session The conversation session. It retains the state of the conversation until now, it must be passed along with the prompt for continuous conversations.
  @param configuration The configuration to use for the request. If nil, the default configuration will be used.

  ## Examples

      iex> {:ok, _session} = OpenAi.call_completion_api("Write an Haiku")
      {:ok,
       [
         %OpenAi.Dtos.State{
           session_id: "cmpl-6kKC9taCBxS05rKgkRtKdkAXekYQq",
           last_request: %OpenAi.Dtos.Request{
             model: "text-davinci-003",
             prompt: "\nWrite an Haiku",
             max_tokens: 20,
             temperature: 0,
             top_p: 1,
             frequency_penalty: 0,
             presence_penalty: 0,
             stop: ["\\n"]
           },
           last_response: %{
             "choices" => [
               %{
                 "finish_reason" => "stop",
                 "index" => 0,
                 "logprobs" => nil,
                 "text" => "\n\nAutumn leaves fall down\nSoftly they whisper goodbye\nUntil we meet again"
               }
             ],
             "created" => 1676498737,
             "id" => "cmpl-6kKC9taCBxS05rKgkRtKdkAXekYQq",
             "model" => "text-davinci-003",
             "object" => "text_completion",
             "usage" => %{
               "completion_tokens" => 18,
               "prompt_tokens" => 5,
               "total_tokens" => 23
             }
           }
         }
       ]}

      iex> {:ok, _session} = OpenAi.call_completion_api("Change the first line of the Haiku you wrote", [
      ...> %OpenAi.Dtos.State{
      ...>   session_id: "cmpl-6kKC9taCBxS05rKgkRtKdkAXekYQq",
      ...>   last_request: %OpenAi.Dtos.Request{
      ...>     model: "text-davinci-003",
      ...>     prompt: "\nWrite an Haiku",
      ...>     max_tokens: 20,
      ...>     temperature: 0,
      ...>     top_p: 1,
      ...>     frequency_penalty: 0,
      ...>     presence_penalty: 0,
      ...>     stop: ["\\n"]
      ...>   },
      ...>   last_response: %{
      ...>     "choices" => [
      ...>       %{
      ...>         "finish_reason" => "stop",
      ...>         "index" => 0,
      ...>         "logprobs" => nil,
      ...>         "text" => "\n\nAutumn leaves fall down\nSoftly they whisper goodbye\nUntil we meet again"
      ...>       }
      ...>     ],
      ...>     "created" => 1676498737,
      ...>     "id" => "cmpl-6kKC9taCBxS05rKgkRtKdkAXekYQq",
      ...>     "model" => "text-davinci-003",
      ...>     "object" => "text_completion",
      ...>     "usage" => %{
      ...>       "completion_tokens" => 18,
      ...>       "prompt_tokens" => 5,
      ...>       "total_tokens" => 23
      ...>     }
      ...>   }
      ...> }
      ...>])
      {:ok,
       [
         %OpenAi.Dtos.State{
           session_id: "cmpl-6kKCgCEfsHOBU2yq3eGrv1XvzBF2n",
           last_request: %OpenAi.Dtos.Request{
             model: "text-davinci-003",
             prompt: "\nWrite an Haiku\n\n\nAutumn leaves fall down\nSoftly they whisper goodbye\nUntil we meet again\nChange the first line of the Haiku you wrote",
             max_tokens: 20,
             temperature: 0,
             top_p: 1,
             frequency_penalty: 0,
             presence_penalty: 0,
             stop: ["\\n"]
           },
           last_response: %{
             "choices" => [
               %{
                 "finish_reason" => "stop",
                 "index" => 0,
                 "logprobs" => nil,
                 "text" => "\n\nSummer fades away\nSoftly it whispers goodbye\nUntil we meet again"
               }
             ],
             "created" => 1676498770,
             "id" => "cmpl-6kKCgCEfsHOBU2yq3eGrv1XvzBF2n",
             "model" => "text-davinci-003",
             "object" => "text_completion",
             "usage" => %{
               "completion_tokens" => 16,
               "prompt_tokens" => 34,
               "total_tokens" => 50
             }
           }
         },
         %OpenAi.Dtos.State{
           session_id: "cmpl-6kKC9taCBxS05rKgkRtKdkAXekYQq",
           last_request: %OpenAi.Dtos.Request{
             model: "text-davinci-003",
             prompt: "\nWrite an Haiku",
             max_tokens: 20,
             temperature: 0,
             top_p: 1,
             frequency_penalty: 0,
             presence_penalty: 0,
             stop: ["\\n"]
           },
           last_response: %{
             "choices" => [
               %{
                 "finish_reason" => "stop",
                 "index" => 0,
                 "logprobs" => nil,
                 "text" => "\n\nAutumn leaves fall down\nSoftly they whisper goodbye\nUntil we meet again"
               }
             ],
             "created" => 1676498737,
             "id" => "cmpl-6kKC9taCBxS05rKgkRtKdkAXekYQq",
             "model" => "text-davinci-003",
             "object" => "text_completion",
             "usage" => %{
               "completion_tokens" => 18,
               "prompt_tokens" => 5,
               "total_tokens" => 23
             }
           }
         }
       ]}

  """
  @spec call_completion_api(
    prompt :: binary(),
    session :: list(State.t()),
    configuration :: nil | Configuration.t()
  ) :: {:ok, list(State.t())} | {:error, binary()}
  def call_completion_api(prompt, session \\ [], configuration \\ nil) do
    Finch.start_link(name: MyFinch)

    headers = ApiHelpers.get_request_headers(configuration)

    {url, request} = create_completion_request(session, prompt, configuration)

    response =
      Finch.build(:post, url, headers, Jason.encode!(request))
      |> Finch.request(MyFinch)

    case response do
      {:ok, %{status: 200, body: body}} ->
        parsed_response = struct!(Response, Jason.decode!(body) |> IO.inspect(label: "parsed response") |> IO.inspect(label: "decoded response"))
        {:ok, [%State{
          session_id: parsed_response["id"],
          last_request: request,
          last_response: parsed_response
        } | session]}

      {:ok, %{status: status, body: body}} ->
        IO.inspect(status)
        IO.inspect(body)
        {:error, "Error. Status: '#{inspect status}', Body: '#{inspect body}'"}

      {:error, reason} ->
        IO.inspect(reason)
        {:error, "Error #{inspect reason}"}

    end
  end

  def extract_conversation([]), do: ""
  def extract_conversation([%{"choices" => %{"text" => text}}]), do: text

  defp create_completion_request(session, prompt, configuration) do
    new_prompt = join_session_inputs(prompt, session)

    # Create a request
    request = %Request{
      model: @completion_type,
      prompt: new_prompt,
      max_tokens: 2000,
      temperature: 0,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0,
      stop: ["\\n"]
    }

    url = "#{ApiHelpers.get_base_url(configuration)}/v1/completions"

    {url, request}
  end

  @spec join_session_inputs(
    prompt :: binary(),
    session :: list(State.t())
  ) :: binary()
  defp join_session_inputs(prompt, session) do
    old_prompt =
      session
      # To obtain the new prompt, we need to send all the conversation in the prompt field of the request.
      # This of course is very costly, because the token takes into consideration the whole prompt when computing.
      |> Enum.map(fn
        %{
          last_request: %{prompt: prompt},
          last_response: %{
            "choices" => [%{"text" => text} | _]
          }
        } -> "#{prompt}\n#{text}"
      end)
      |> Enum.reverse()
      |> Enum.join("\n")

    old_prompt <> "\n" <> prompt
  end
end
