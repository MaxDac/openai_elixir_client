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

The API does not currently support conversation context by keeping the ID of the conversation. The only way to keep the context is to send all the conversation along with the prompt, so for instance if one sends <sentence1> and then, based on the response, wants to send <sentence2>, they have to send both the sentences the second time, and this would mean having a different first response in the first place. [More information here](https://community.openai.com/t/conversation-id/33270).
  
It would be impossible to build an AI-managed RPG chat then, having that the history would change and the cost of sending all the prompts would be prohibitive.
