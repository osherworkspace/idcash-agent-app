# ID-CASH Agent App — Flutter foundation

Agent first-launch onboarding uses the agent-specific promotional slide and the customer verification slides. Skip / Next / Get started are supported and first-launch completion persists across restarts.

The Agent App must remain separate from the Customer App. Agent login, wallet and cardless withdrawal API wiring follow after approved agent authentication is implemented.

## Original artwork

Extract the supplied onboarding ZIP and copy the files from `agent/assets/images/` into `assets/images/` in this repository. The default CI substitutes transparent placeholder images **only for compilation**; the original artwork is not embedded in GitHub yet. Do not distribute an APK containing these placeholders as a branded release.

To run locally: `flutter create . --platforms=android --project-name=idcash_agent_app`, `flutter pub get`, `flutter run`.

Do not include backend database connection strings, API secrets or Twilio credentials in the mobile app.
