defmodule OpenAi.Dtos.Configuration do
  @moduledoc """
  Configuration data structure.
  """

  defstruct key: "",
            base_url: "https://api.openai.com"

  @typedoc """
  The key represents the OpenAI token that will be used to authenticate to the API.
  """
  @type t :: %__MODULE__{
    key: binary(),
    base_url: binary()
  }

  def new_from_env do
    %__MODULE__{
      key: System.get_env("OPENAI_API_KEY")
    }
  end
end
