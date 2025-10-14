___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "displayName": "Triggerbee Event Tag",
  "description": "Send Triggerbee events from GTM (Goal, Goal with Identification, or Purchase).",
  "securityGroups": [],
  "categories": ["TAG"],
  "id": "triggerbee-event-tag",
  "version": "1.0.0",
  "author": "Triggerbee",
  "containerContexts": ["WEB"],
  "permissions": [
    "access_globals",
    "access_logging",
    "access_window",
    "read_data_layer",
    "run_js"
  ],
  "resources": {
    "js": [
      "callInWindow",
      "makeString",
      "makeNumber",
      "logToConsole"
    ]
  }
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "eventType",
    "displayName": "Event type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "goal",
        "displayValue": "Goal"
      },
      {
        "value": "goalIdentify",
        "displayValue": "Goal with Identification"
      },
      {
        "value": "purchase",
        "displayValue": "Purchase"
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "debugMode",
    "displayName": "Enable Debug Mode",
    "simpleValueType": true,
    "defaultValue": false,
    "help": "When enabled, all actions and data will be logged to the browser console for debugging."
  },

  // === GOAL ===
  {
    "type": "GROUP",
    "name": "goalData",
    "displayName": "Goal settings",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "goalName",
        "displayName": "Select goal",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "View item", "displayValue": "View item" },
          { "value": "Add to cart", "displayValue": "Add to cart" },
          { "value": "Initiate checkout", "displayValue": "Initiate checkout" },
          { "value": "Complete purchase", "displayValue": "Complete purchase" },
          { "value": "Add to wishlist", "displayValue": "Add to wishlist" },
          { "value": "Register membership", "displayValue": "Register membership" },
          { "value": "Logged in", "displayValue": "Logged in" }
        ],
        "simpleValueType": true,
        "notSetText": "Select goal",
        "help": "Select one of our predefined goals, or use a custom name below."
      },
      {
        "type": "TEXT",
        "name": "customGoalName",
        "displayName": "Custom goal name (optional)",
        "simpleValueType": true,
        "help": "Overrides the selected goal name. Must be plain text (not a number or variable)."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "goal",
        "type": "EQUALS"
      }
    ]
  },

  // === GOAL WITH IDENTIFICATION ===
  {
    "type": "GROUP",
    "name": "goalIdentifyData",
    "displayName": "Goal with Identification settings",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "goalIdentityName",
        "displayName": "Select goal",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "Logged in", "displayValue": "Logged in" },
          { "value": "Register membership", "displayValue": "Register membership" },
          { "value": "Submitted contact form", "displayValue": "Submitted contact form" }
        ],
        "simpleValueType": true,
        "help": "Select one of our predefined goals, or add a custom goal name below."
      },
      {
        "type": "TEXT",
        "name": "customIdentityGoalName",
        "displayName": "Custom goal name (optional)",
        "simpleValueType": true,
        "help": "Overrides the selected goal name. Must be plain text (not a number or variable)."
      },
      {
        "type": "TEXT",
        "name": "eventEmail",
        "displayName": "Email address variable (optional)",
        "simpleValueType": true,
        "help": "Variable that contains the email address performing the event (e.g. {{customer_email}})."
      },
      {
        "type": "TEXT",
        "name": "eventContactID",
        "displayName": "Contact ID variable (optional)",
        "simpleValueType": true,
        "help": "Variable that contains the contact ID for identification (e.g. {{contact_id}})."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "goalIdentify",
        "type": "EQUALS"
      }
    ]
  },

  // === PURCHASE ===
  {
    "type": "GROUP",
    "name": "purchaseData",
    "displayName": "Purchase settings",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "revenue",
        "displayName": "Revenue variable (recommended)",
        "simpleValueType": true,
        "help": "Insert the variable containing the total purchase amount (e.g. {{value}})."
      },
      {
        "type": "TEXT",
        "name": "orderId",
        "displayName": "Order ID variable (optional)",
        "simpleValueType": true,
        "help": "Insert the variable containing the transaction/order ID (e.g. {{order_id}})."
      },
      {
        "type": "TEXT",
        "name": "couponCode",
        "displayName": "Coupon code variable (optional)",
        "simpleValueType": true,
        "help": "Insert the variable containing the coupon code (e.g. {{coupon_code}})."
      },
      {
        "type": "TEXT",
        "name": "userEmail",
        "displayName": "Customer email variable (optional)",
        "simpleValueType": true,
        "help": "Insert the variable containing the customer email address (e.g. {{customer_email}})."
      },
      {
        "type": "TEXT",
        "name": "contactID",
        "displayName": "Contact ID variable (optional)",
        "simpleValueType": true,
        "help": "Insert the variable containing the contact ID (e.g. {{contact_id}})."
      }
    ],
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ]
  }
]




___SANDBOXED_JS_FOR_WEB_TEMPLATE___
const logToConsole = require('logToConsole');
const callInWindow = require('callInWindow');
const makeString = require('makeString');
const makeNumber = require('makeNumber');

const debugMode = data.debugMode === true;

// === Helper Functions ===
const debugLog = (msg) => debugMode && logToConsole(msg);
const safeString = (val) => val ? makeString(val) : '';
const safeNumber = (val, def = -1) => val ? makeNumber(val) : def;

function sendTriggerbeeEvent(eventObj, successMsg) {
  callInWindow('triggerbee.event', eventObj);
  debugLog(successMsg);
  data.gtmOnSuccess();
}

// === MAIN LOGIC ===
const eventType = data.eventType;
debugLog('Initiating Triggerbee Event type: ' + eventType);

switch (eventType) {

  // ---- GOAL ----
  case 'goal': {
    const goalName = safeString(data.goalName);
    const customGoalName = safeString(data.customGoalName);
    const goalEventName = customGoalName || goalName;

    if (!goalEventName) {
      debugLog('Error: Goal name is missing');
      return data.gtmOnFailure();
    }

    sendTriggerbeeEvent(
      { type: 'goal', name: goalEventName },
      'Goal event sent with name: ' + goalEventName
    );
    break;
  }

  // ---- GOAL WITH IDENTIFICATION ----
  case 'goalIdentify': {
    const goalName = safeString(data.customIdentityGoalName) || safeString(data.goalIdentityName);
    const email = safeString(data.eventEmail);
    const contactId = safeString(data.eventContactID);

    if (!goalName || (!email && !contactId)) {
      debugLog('Error: Missing goalIdentify name or identity info');
      return data.gtmOnFailure();
    }

    const identity = {};
    if (email) identity.email = email;
    if (contactId) identity.contactid = contactId;

    sendTriggerbeeEvent(
      {
        type: 'goal',
        name: goalName,
        data: { identity }
      },
      'GoalIdentify event sent with name: ' + goalName
    );
    break;
  }

  // ---- PURCHASE ----
  case 'purchase': {
    const revenue = safeNumber(data.revenue);
    const orderId = safeString(data.orderId);
    const couponCode = safeString(data.couponCode);
    const email = safeString(data.userEmail);
    const contactId = safeString(data.contactID);

    const event = {
      type: 'purchase',
      id: orderId || undefined,
      data: {}
    };

    if (revenue >= 0) event.data.revenue = revenue;
    if (couponCode) event.data.couponCode = couponCode;

    const identity = {};
    if (email) identity.email = email;
    if (contactId) identity.contactid = contactId;
    if (Object.keys(identity).length > 0) event.data.identity = identity;

    sendTriggerbeeEvent(
      event,
      'Purchase event sent with Order ID: ' + (orderId || 'N/A')
    );
    break;
  }

  // ---- DEFAULT ----
  default:
    debugLog('Invalid event type selected');
    data.gtmOnFailure();
}




___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "triggerbee"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "triggerbee.event"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 28/10/2024, 08:39:40
Updated on 23/04/2025 14:24
