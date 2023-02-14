defmodule Request do
  @moduledoc """
  The request for OpenAI API for text completion.
  """

  defstruct model: "",
            prompt: "",
            max_tokens: 0,
            temperature: 0,
            top_p: 0,
            frequency_penalty: 0,
            presence_penalty: 0
end
