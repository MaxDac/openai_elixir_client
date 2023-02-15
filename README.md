# OpenAi

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `open_ai` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:open_ai, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/open_ai>.

# openai_elixir_client

## Note

In order to keep an ongoing conversation, it's necessary to send the **whole** conversation to the OpenAI API.
This means that all the conversation, including the previous completion, must be send to the API.
This can prove very costly, considering that even the prompt interpretation costs tokens.
