defmodule OpenAi.Completion.Dtos.Usage do
  @derive Jason.Encoder
  defstruct prompt_tokens: 0,
            completion_tokens: 0,
            total_tokens: 0

  @type t :: %__MODULE__{
    prompt_tokens: integer(),
    completion_tokens: integer(),
    total_tokens: integer()
  }
end

