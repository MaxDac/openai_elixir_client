defmodule Request do
  @moduledoc """
  The request for OpenAI API for text completion.
  """

  @derive Jason.Encoder
  defstruct model: "",
            prompt: "",
            max_tokens: 0,
            temperature: 0,
            top_p: 0,
            frequency_penalty: 0,
            presence_penalty: 0,
            stop: []

  @type t :: %__MODULE__{
          model: binary(),
          prompt: binary(),
          max_tokens: integer(),
          temperature: float(),
          top_p: float(),
          frequency_penalty: float(),
          presence_penalty: float(),
          stop: [binary()]
        }
end
