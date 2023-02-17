defmodule OpenAi.Completion.Dtos.Choice do
  @derive Jason.Encoder
  defstruct index: 0,
            text: "",
            logprobs: %{},
            finish_reason: ""

  @type t :: %__MODULE__{
    index: integer(),
    text: binary(),
    logprobs: map(),
    finish_reason: binary()
  }
end

