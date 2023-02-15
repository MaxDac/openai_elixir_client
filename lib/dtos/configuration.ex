defmodule OpenAi.Dtos.Configuration do
  @moduledoc """
  Configuration data structure.
  """

  defstruct key: ""

  @type t :: %__MODULE__{
    key: binary()
  }

  def new_from_env do
    %__MODULE__{
      key: System.get_env("OPENAI_API_KEY")
    }
  end
end
