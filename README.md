# Bucket2Slack
#### [Bitbucket’s PR => Slack](https://github.com/ixnixnixn/bucket2slack)

Slack’s integration with Bitbucket only supports POST Hook, which contains only sending commits information. Instead, Bucket2Slack forwards the Bitbucket’s pull request hook to notify your slack's channel.

- Bitbucket's Pull Request Hook Management: [docs](https://confluence.atlassian.com/display/BITBUCKET/Pull+Request+POST+hook+management)
- Slack’s web API: [docs](https://api.slack.com/web)

## Hook Supported

| Event                     | Description |
| ------------------------- | ----------- |
| Approve/Unapprove         | Fires when user sets or unsets Approve for a pull request |
| Comments                  | Fires when a user creates, edits, or deletes a pull request comment |
| Create/Edit/Merge/Decline | Fires when a user creates, edits, merges, or declines a pull request |

The Bitbucket's API doesn't have complete event's information. For example; pull request approval only includes user who approves or disapproves, editing pull request doesn't give the pull request's number or link, etc.

## Installation

- Fork the repository
- Deploy to heroku or roll your own server
- Set config variables in `config.yml` file (see `config.yml.example`).

## Usage

- Go to your Bitbucket's repository page: `Settings > Hooks > Add Hook 'Pull Request POST'`.
- Insert `http://<server>/team/{/channel}` in the URL. Channel is optional, default is set to `#general` but you could set the channel that you want to notify from the config vars or add it to the URL

## License

MIT

## References
- [Luiz’s hook](https://github.com/lfilho/bitbucket-slack-pr-hook)
- [bitbucket-pull-request-connector](https://github.com/kfr2/bitbucket-pull-request-connector)
