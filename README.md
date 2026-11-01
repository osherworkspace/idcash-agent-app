# ID-CASH Agent App — Flutter foundation

Agent first-launch onboarding uses the agent-specific promotional slide and the customer verification slides. Skip / Next / Get started are supported and first-launch completion persists across restarts.

The Agent App must remain separate from the Customer App. Agent login, wallet and cardless withdrawal API wiring follow after approved agent authentication is implemented.

## Original artwork

Extract the supplied onboarding ZIP and copy the files from `agent/assets/images/` into `assets/images/` in this repository. The default CI substitutes transparent placeholder images **only for compilation**; the original artwork is not embedded in GitHub yet. Do not distribute an APK containing these placeholders as a branded release.

To run locally: `flutter create . --platforms=android --project-name=idcash_agent_app`, `flutter pub get`, `flutter run`.

Do not include backend database connection strings, API secrets or Twilio credentials in the mobile app.

## Original images: upload once to the feature branch

The source uses the real uploaded ID-CASH slide art and app icon, not placeholders. GitHub binary file upload is not available through the connected source-editing tool, so the supplied **idcash_onboarding_assets.zip** must be added to this feature branch by using GitHub **Add file → Upload files**. Add the ZIP to the repository root under the exact filename `idcash_onboarding_assets.zip`, then commit to `feature/agent-flutter-onboarding`. The ZIP is the one supplied in the ChatGPT conversation and contains both user and agent originals.

On the next CI run, `python3 scripts/install_brand_assets.py --app agent` automatically extracts the original PNGs, verifies the exact SHA-256 signatures, then `flutter_launcher_icons` generates the branded Android launcher icons. The release/build job **fails rather than substituting placeholders** if the ZIP is missing or any image is changed. It does not rely on image-generation placeholders.

To install locally, put the same ZIP in the project root and run `python3 scripts/install_brand_assets.py --app agent` before `flutter pub get` and your Flutter build.

## Current uploaded original artwork

The original `ID-CASH_Agent_App_Images.zip` is already present in this branch's root. Its archive entries are flat PNG filenames. CI now unpacks this existing upload with `python3 scripts/install_brand_assets.py --app agent`, verifies the uploaded images against pinned SHA-256 hashes and generates Android launcher icons. **No additional image upload or archive rename is necessary.**
