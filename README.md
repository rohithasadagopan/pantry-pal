# Pantry Pal

Build Pantry to Plate, an Alexa+ meal-planning agent for the Amazon Build, Ship, Shape hackathon (Alexa+ track). Submission closes October 23, 2026 at 12:00 pm PT.

What it does: A user asks "plan dinners for four this week under $80." The agent checks the saved pantry, finds recipes that fit saved preferences and the user's busy nights, shows the week as an interactive grid, and builds a grocery cart. The user confirms before anything is bought. The next session starts from the saved pantry, preferences and meal history.

Requirements:
- Self-hosted MCP server using Streamable HTTP, MCP spec 2025-11-25. It exposes tools for pantry, recipes, calendar and cart. Make it reachable at a public URL.
- Web simulator that acts as the Alexa+ client, since the Alexa+ MCP toolkit isn't open to hackathon entrants.
- MCP Apps for the week grid and the product carousel.
- An Agent Skill that teaches the meal-planning workflow.
- An agent built with the Strands Agents SDK on Amazon Bedrock, which chains the tools for one request. This is for the AWS Builder mini challenge, so Bedrock must be genuinely called in the code, with setup documented in the README.
- Pantry, preferences and meal history persist across sessions, stored in Lovable Cloud.
- Checkout uses a mock store with the same session flow as a real one. Say so in the README and the UI. Don't claim real purchases.
- Public GitHub repository with an MIT license, setup instructions in the README, and the Agent Skill in the repo. This is for the Open Source mini challenge.
- Include a short demo flow for a 2–3 minute video: one request in the simulator, the week grid, cart confirmation, then a new session that remembers the pantry.

Before building the full app, confirm that the Lovable backend can serve a Streamable HTTP MCP endpoint. If it can't, host the MCP server elsewhere and keep the web simulator on Lovable, and tell me which option you chose.

Publish the simulator when it works, and report the published URL, the GitHub repo URL, and the MCP endpoint URL.

This project was built with [Lovable](https://lovable.dev).

## Build with Lovable

Continue developing this project in the [Lovable editor](https://lovable.dev/projects/f4a9bce6-386d-4d5b-b3b0-a0e634d82ae5).

- **Ship faster**: describe what you want to build and Lovable handles the code.
- **Stay in sync**: every change made in Lovable is committed straight to this repository.
- **Full ownership**: this code is yours. Push to `main` on GitHub and your changes sync back into Lovable, ready for your next prompt.

## Development

Prefer working locally? You need Node.js and npm — [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating).

```sh
git clone <this-repository-url>
cd <repository-name>
npm i
npm run dev
```
