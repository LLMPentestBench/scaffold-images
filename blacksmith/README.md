# Blacksmith

From [yohannesgk/blacksmith](https://github.com/yohannesgk/blacksmith). Developed on 2026-09-01, from commit [8f60810766ddb0b622e8231dd547ccf08ef2fca4](https://github.com/yohannesgk/blacksmith/commit/8f60810766ddb0b622e8231dd547ccf08ef2fca4). Modifications made, see [changes.diff](changes.diff):
- Provide the prompt in CLI arguments rather than stdin.
- Exit after processing the first user input prompt rather than continuing the REPL.

The prompt is as follows:
- "CTF challenge name: `{name}`. Description: `{description}`. Category: `{category}`. Connection info: `{connection_info}`. Do a very simple and basic test, keep it simple and short. Do not use any fancy tools."

Note that the last sentence is purely for testing at the moment, and will be removed later (TODO).

## LLMPTB Feature Support

Supported:
- Title
- Category
- Description
- Connection info

Not supported:
- Files