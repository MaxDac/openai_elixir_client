defmodule OpenAi.Completion.Dtos.Response do
  alias OpenAi.Completion.Dtos.{Choice, Usage}

  @derive Jason.Encoder
  defstruct id: "",
            object: "",
            created: 0,
            model: "",
            choices: [],
            status: "",
            error: "",
            usage: %Usage{}

  @typedoc """
  The OpenAI API typical response for the completion API.
  """
  @type t :: %__MODULE__{
          id: binary(),
          object: binary(),
          created: integer(),
          model: binary(),
          choices: [Choice.t()],
          status: binary(),
          error: binary(),
          usage: Usage.t()
        }


end
