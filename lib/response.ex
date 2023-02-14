defmodule Response do
  @derive Jason.Encoder
  defstruct id: "",
            object: "",
            created: 0,
            model: "",
            choices: [],
            status: "",
            error: "",
            usage: %{}

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

  defmodule Response.Choice do
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

  defmodule Response.Usage do
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
end
