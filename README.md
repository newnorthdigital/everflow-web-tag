# Everflow - GTM Web Tag Template

Google Tag Manager web tag template for [Everflow](https://everflow.io) performance marketing platform. Supports click tracking and conversion tracking via the Everflow JavaScript SDK.

## Features

- **Click tracking** - Record affiliate clicks with Offer ID and Affiliate ID. Sets a first-party cookie for conversion attribution.
- **Conversion tracking** - Fire conversions with amount, order ID, coupon code, and event identifiers.
- **Custom tracking domain** - Works with any Everflow tracking domain.
- Built-in Consent Mode gate: follows GTM Consent Mode by default, firing only once `ad_storage` is granted and waiting for consent otherwise.
- **Debug logging** - Optional console logging for troubleshooting in GTM Preview mode.

## Installation

### From the Community Template Gallery

1. In your GTM container, go to **Templates** > **Tag Templates** > **Search Gallery**
2. Search for **Everflow Conversion Tracking by New North Digital**
3. Click **Add to workspace**

### Manual installation

1. Download `template.tpl` from this repository
2. In GTM, go to **Templates** > **Tag Templates** > **New**
3. Click the three-dot menu > **Import**
4. Select the downloaded `template.tpl` file

## Setup

### Click tracking

Create a tag with the following settings:

| Field | Description |
|-------|-------------|
| Action type | Click tracking |
| Tracking domain | Your Everflow tracking domain (e.g. `www.example-tracking.com`) |
| Offer ID | Numeric Everflow Offer ID |
| Affiliate ID | Numeric Everflow Affiliate ID |

**Trigger:** Fire on all pages where you want to track affiliate clicks (typically a landing page trigger).

### Conversion tracking

Create a tag with the following settings:

| Field | Description |
|-------|-------------|
| Action type | Conversion tracking |
| Tracking domain | Your Everflow tracking domain |
| Offer ID | Everflow Offer ID (optional if Advertiser ID is set) |
| Advertiser ID | Everflow Advertiser ID (optional if Offer ID is set) |
| Transaction ID | The Everflow transaction ID from the click cookie (optional, improves attribution) |
| Amount | Sale/revenue amount (optional) |
| Order ID | Unique order reference (optional) |
| Coupon code | Promotional code used (optional) |
| Event ID | Post-conversion event identifier (optional) |
| Advertiser Event ID | Global advertiser event identifier (optional) |

**Trigger:** Fire on the order confirmation / thank-you page.

## Consent

Both tracking modes set and read first-party cookies for attribution, which needs `ad_storage`. The **Consent handling** field controls how the tag reacts to GTM Consent Mode:

- **Follow GTM Consent Mode (ad_storage)** (default, recommended) - fires only once `ad_storage` is granted, and waits via a consent listener if it is not yet given. Consent that is never configured counts as granted, so sites without Consent Mode are unaffected.
- **Fire immediately (I gate consent elsewhere)** - runs right away, for when you gate consent with GTM's tag-level consent settings or a consent trigger.

## Permissions

This template requests the following permissions:

| Permission | Reason |
|------------|--------|
| Inject script | Loads the Everflow SDK from your tracking domain |
| Access globals | Calls `EF.click` and `EF.conversion` on the global scope |
| Access consent | Reads `ad_storage` consent state and listens for changes |
| Logging | Debug messages in GTM Preview mode |

## Resources

- [Everflow Developer Hub](https://developers.everflow.io/)
- [Everflow SDK Documentation](https://developers.everflow.io/docs/everflow-sdk/)
- [Everflow Helpdesk](https://helpdesk.everflow.io/)

## Author

Created and maintained by [Freek Kampen](https://freekkampen.com) at [New North Digital](https://newnorth.digital/?utm_source=github&utm_medium=referral&utm_campaign=gtm-template-gallery).

## License

Apache 2.0 - see [LICENSE](LICENSE).
