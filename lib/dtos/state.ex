defmodule OpenAi.Dtos.State do
  @moduledoc """
  Represents the state of a particular chat session.
  """

  alias OpenAi.Dtos.Response
  alias OpenAi.Dtos.Request

  defstruct session_id: "",
            last_request: nil,
            last_response: nil

  @typedoc """
  The session accumulated within the context of an ongoing conversation.
  """
  @type t :: %__MODULE__{
    session_id: binary(),
    last_request: Request.t(),
    last_response: Response.t()
  }
end
