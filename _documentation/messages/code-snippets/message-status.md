---
title: Receive message status callback
navigation_weight: 6
---

# Message status

In this code snippet you will see how to receive message status updates.

> **NOTE:** Messages API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).

## Example

Ensure that your message status [webhook is set](/messages/code-snippets/configure-webhooks) in the Dashboard. As a minimum your handler must return a 200 status code to avoid unnecessary callback queuing. Make sure your webhook server is running before testing your Messages application.

```code_snippets
source: '_examples/messages/message-status'
application:
  type: messages
  name: 'Message status'
```

## Try it out

The webhook is invoked on changing message status and details printed to the console.
