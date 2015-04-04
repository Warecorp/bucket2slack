# Bucket2Slack
#### [Bitbucket’s PR => Slack](https://github.com/ixnixnixn/bucket2slack)

Slack’s integration with Bitbucket only supports POST Hook, which is only sending information when there’s a commit. Instead, Bucket2Slack forwards the Bitbucket’s Pull Request Hook to notify slack.

- Bitbucket's Pull Request Hook Management: [docs](https://confluence.atlassian.com/display/BITBUCKET/Pull+Request+POST+hook+management)
- Slack’s web API: [docs](https://api.slack.com/web)

## Hook Supported

| Event                     | Description |
| ------------------------- | ----------- |
| Approve/Unapprove         | Fires when user sets or unsets Approve for a pull request |
| Comments                  | Fires when a user creates, edits, or deletes a pull request comment |
| Create/Edit/Merge/Decline | Fires when a user creates, edits, merges, or declines a pull request |

The limitation from Bitbucket's API causes many events that doesn't have complete information. For example, approval events only include user who approve/disapprove, edit PR doesn't give PR's number, etc.

## Usage

- Obtain Slack's API token from here: https://api.slack.com/web
- Go to your repository page: `Settings > Hooks > Add Hook 'Pull Request POST'`
- Insert `http://<server>{/channel}` in the URL. Channel is optional, default is set to `#general` or you could set default channel in the config

## Installation

- Fork the repository
- Deploy to heroku or roll your own server
- Set config variables in your dashboard or use `.env` file;
  - `SLACK_TEAM`: your team's domain
  - `SLACK_TOKEN`: your API token
  - `SLACK_DEFAULT` (optional): your default channel if not specified

## License

MIT

## References
- [Luiz’s hook](https://github.com/lfilho/bitbucket-slack-pr-hook)
- [bitbucket-pull-request-connector](https://github.com/kfr2/bitbucket-pull-request-connector)
