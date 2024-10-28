# Triggerbee Event Logger Template for Google Tag Manager

The **Triggerbee Event Logger Template** enables seamless integration of Triggerbee event logging with Google Tag Manager (GTM), allowing you to send `goal` and `purchase` events directly to Triggerbee.

This template simplifies the process of sending events to Triggerbee, helping you track key actions, monitor conversions, and personalize experiences based on visitor interactions.

## Features

- **Send Goal Events:** Easily log `goal` events to Triggerbee with custom or standardized goal names.
- **Track Purchase Events:** Send detailed `purchase` events, including revenue, order ID, coupon codes, and customer email.
- **Easy Integration:** Integrate seamlessly with your existing GTM setup and Triggerbee tracking.
- **Data Layer Compatibility:** Utilize GTM's Data Layer variables for dynamic event data.

## Requirements

- **Google Tag Manager account**
- **Triggerbee account** with tracking implemented on your website (either via the Triggerbee Tracking GTM Template or your own setup)
- **Website** with Google Tag Manager installed
- **Triggerbee script** must be loaded and active before the event logger tag executes

## Installation

### Step 1: Install and Configure the Template

1. In GTM, navigate to `Templates` > `Tag Templates` and click **New**.
2. Click on the menu icon (three dots) and select **Import**.
3. Import the Triggerbee Event Logger Template file.
4. Save the template.

### Step 2: Add Global Variable Permission

1. In the template editor, go to the **Resources** tab.
2. Click on **Add New Resource** and select **Global Variable**.
3. Enter `triggerbee` as the variable name.
4. Set the necessary read/write permissions.
5. Save the template.

### Step 3: Create a New Tag Using the Template

1. Go to `Tags` > **New**.
2. Select the **Triggerbee Event Logger Template** from the list of tag types.
3. Configure the tag settings:
   - **Event Type:** Choose `goal` or `purchase`.
   - **Goal Name:** Select a standardized goal name from the dropdown.
   - **Custom Goal Name:** *(Optional)* Provide a custom goal name. This overrides the standard goal name if not empty.
   - **Revenue:** Input the Data Layer variable representing revenue *(used only for purchase events)*.
   - **Order ID:** Input the Data Layer variable for the order ID *(used only for purchase events)*.
   - **Coupon Code:** Input the Data Layer variable for the coupon code *(used only for purchase events)*.
   - **User Email:** Input the Data Layer variable for the customer's email *(used only for purchase events)*.

### Step 4: Add Triggers

1. Assign a **Trigger** to the Triggerbee Event Logger Tag to determine when the tag should fire.
2. **Ensure Proper Firing Order:**
   - The tag should fire after the Triggerbee tracking tag has fired and Triggerbee is confirmed active.
   - You can achieve this by using the `triggerbeeActive` Data Layer event as a trigger.
   - Alternatively, set up a custom event that signifies Triggerbee is ready.
3. Click **Save**.

### Step 5: Publish

1. Use GTM's **Preview Mode** to test your setup.
2. Once verified, click **Submit** to publish your changes.

## Usage

Once installed and configured, the Triggerbee Event Logger will allow you to send `goal` and `purchase` events to Triggerbee based on user interactions and events on your website.

- **Goal Events:** Use this to log specific actions that users take on your site that are non-revenue driven. For example, "Add to cart", "Initialize checkout", "Viewed product", "Submitted support ticket", etc. These goals are key events in the customer journey, and can be used to create audiences and profile filters.
- **Purchase Events:** Use this to send detailed purchase information to Triggerbee, which can include revenue, order IDs, coupon codes, and customer emails. Purchase events with revenue data will help you see how your campaigns perform in terms of driving revenue.

## Important Notes

- **Triggerbee tracking tag must be run BEFORE the events:** The Triggerbee tracking script must have been loaded and initialized **before** the event logger tag is fired.
- **Data Layer Variable Availability:** Confirm that all Data Layer variables used in the tag (e.g., revenue, order ID, user email) are populated at the time the tag fires.
- **Event Timing:** Align the firing of the event logger tag with appropriate events to ensure accurate tracking. For example, fire purchase events *after* a successful transaction.

## Support

If you need assistance:

- **Triggerbee Documentation:** Refer to Triggerbee's official documentation for detailed guidance.
- **Contact Triggerbee Support:** Reach out to Triggerbee's support team for specialized help.
