# PRD Sharing for Sign-Off

When one user shares a refined PRD with another for approval/sign-off (e.g., PM shares with Engineering Lead or Design), follow one of these approaches.

---

## Creator Sign-Off First

**MANDATORY: Always ask the user** "Which role are you? (PM, Engineering Lead, or Design)" **before** filling any Sign-Off. Do NOT assume or default to PM. Do NOT pre-fill any role as Approved without the user explicitly identifying their role. Creator approves for their role only. Other roles stay Pending for roles the creator does not represent. Record approval only for the role the user identifies.

**Workflow order:** Creator signs off for their role first (among the three roles). Collect sign-off **only after** the user has approved the PRD content—sign-off is the last step before handoff. Do not mark Approved or hand off (new_task) or call attempt_completion until user has given explicit sign-off.

## One User = One Role

No user may approve for more than one role. Each role requires a different approver. Creator approves for their role; the other two roles must be filled by different people when they receive the shared PRD. Recipients approve for their role only when they open the shared link.

---

## Option A: Manual Hand-Off (Direct Navigation to Approval)

**Preferred when the recipient uses Nayan.**

1. **Share the task** containing the refined PRD (Share button → organization or public link).
2. **Direct the recipient** to the PRD approval process:
    - **Nayan web:** When the recipient opens the shared link, they should be navigated to the PRD approval flow — view refined-prd.md and complete Sign-Off (Section 1) for their role (PM, Engineering Lead, or Design).
    - **Nayan extension:** If the recipient has the extension, they can open the shared task and switch to **PRD** mode to complete their role's Sign-Off in refined-prd.md.
3. **Include in share message:** "Please review and approve the PRD. Open the shared link and complete your role's Sign-Off (Approver Name, Sign-Off Date, Status = Approved) in Section 1."
4. **Recipient action:** Open shared link → navigate to PRD approval → fill Approver Name (use Nayan logged-in user from environment_details), Sign-Off Date, set Status = Approved for their role.

**Implementation note:** The shared task view (`/shared/[shareId]`) should detect when the task contains a refined PRD and offer a clear "Approve PRD" / "Complete Sign-Off" CTA that navigates the user to the PRD approval process (e.g., open in PRD mode or a dedicated approval form).

---

## Option B: Slack or Gmail Integration (Send for Approval)

**Use when manual hand-off is not practical** — e.g., recipient is external, prefers email, or uses Slack for approvals.

1. **Configure integration** (when available):
    - **Gmail/Email:** Configure SMTP (SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD, SMTP_FROM) in Nayan web. Use "Send PRD for approval" to email refined-prd.md to approvers.
    - **Slack:** Configure Slack OAuth (SLACK_CLIENT_ID, SLACK_CLIENT_SECRET). Use "Share PRD to Slack" to post refined-prd.md or a link to the shared task in a channel or DM for approval.
2. **Email content:** Include refined-prd.md (or link to shared task), instructions to complete Sign-Off for their role, and a link back to the shared task for approval.
3. **Slack content:** Post summary + link to shared task; recipient opens link and completes Sign-Off per Option A.

**Implementation note:** Nayan web supports SMTP and Slack OAuth env vars. A "Send for approval" action can be added to the PRD mode or share flow to email/Slack the refined PRD to specified approvers.

---

## Process Summary

| Approach            | When to Use                       | Recipient Action                                                               |
| ------------------- | --------------------------------- | ------------------------------------------------------------------------------ |
| **Manual hand-off** | Recipient uses Nayan; same org   | Open shared link → navigate to PRD approval → complete Sign-Off for their role |
| **Slack**           | Team uses Slack for approvals     | Receive Slack message with link → open shared task → complete Sign-Off         |
| **Gmail/Email**     | Recipient prefers email; external | Receive email with refined-prd.md or link → open and complete Sign-Off         |

---

## Scope Mode Instruction

When the user says they need to share the PRD with another person for sign-off:

1. **Ask:** "Will the approver use Nayan (extension or web), or do you prefer to send via Slack or email?"
2. **Manual hand-off:** Instruct user to share the task (Share button) and tell the recipient to open the link and complete their role's Sign-Off. Include the share link in your response.
3. **Slack/Email:** If integration is configured, offer to send the refined PRD via Slack or email. If not configured, instruct user to manually copy refined-prd.md and send via their preferred channel, with a link to the shared task when available.

---

## References

- `.nayan/guidance/sdlc-human-gates.md` — PRD sign-off gate, Approver Name
- `.nayan/guidance/prd-template-v2.md` — Sign-Off table format
- `.nayan/guidance/plan-input-requirements.md` — Plan readiness, Sign-Off requirements
