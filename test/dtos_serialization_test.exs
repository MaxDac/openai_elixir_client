defmodule OpenAiTest do
  use ExUnit.Case
#  doctest OpenAi.Completion

  defmodule TestNested do
    @derive Jason.Encoder
    defstruct a: 1,
              b: "a" 
  end

  defmodule Test do
    @derive Jason.Encoder
    defstruct a: %TestNested{}
  end

  test "Completion deserialization test" do
    test_string = %{
      "choices" => [
        %{
          "finish_reason" => "stop",
          "index" => 0,
          "logprobs" => nil,
          "text" => "\n\n2020 was a year of unprecedented challenges and opportunities."
        }
      ],
      "created" => 1676562880,
      "id" => "cmpl-6kasiC4UWA92QquQOqnnpF1BVIRHq",
      "model" => "text-davinci-003",
      "object" => "text_completion",
      "usage" => %{
        "completion_tokens" => 12,
        "prompt_tokens" => 11,
        "total_tokens" => 23
      }
    }

    IO.inspect(test_string["choices"], label: "getting choices")

    deserialized =
      struct(OpenAi.Completion.Dtos.Response, test_string |> IO.inspect(label: "test string"))
      |> IO.inspect()

    assert 1 == deserialized.choices |> Enum.count()
  end
end
