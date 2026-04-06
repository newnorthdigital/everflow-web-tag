___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Everflow",
  "categories": ["AFFILIATE_MARKETING", "CONVERSIONS"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "New North Digital",
    "thumbnail": ""
  },
  "description": "Everflow performance marketing platform. Click tracking and conversion tracking via the Everflow JavaScript SDK.",
  "containerContexts": ["WEB"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "actionType",
    "displayName": "Action type",
    "macrosInSelect": false,
    "selectItems": [
      {"value": "click", "displayValue": "Click tracking"},
      {"value": "conversion", "displayValue": "Conversion tracking"}
    ],
    "simpleValueType": true,
    "help": "Click tracking records affiliate clicks and sets a first-party cookie. Conversion tracking fires on the order confirmation page."
  },
  {
    "type": "TEXT",
    "name": "trackingDomain",
    "displayName": "Tracking domain",
    "simpleValueType": true,
    "help": "Your Everflow tracking domain including subdomain (e.g. www.example-tracking.com). Do not include https:// or a trailing slash.",
    "alwaysInSummary": true,
    "valueValidators": [{"type": "NON_EMPTY"}]
  },
  {
    "type": "TEXT",
    "name": "offerId",
    "displayName": "Offer ID",
    "simpleValueType": true,
    "help": "The numeric Everflow Offer ID.",
    "valueValidators": [{"type": "NON_EMPTY"}],
    "enablingConditions": [{"paramName": "actionType", "paramValue": "click", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "affiliateId",
    "displayName": "Affiliate ID",
    "simpleValueType": true,
    "help": "The numeric Everflow Affiliate ID.",
    "valueValidators": [{"type": "NON_EMPTY"}],
    "enablingConditions": [{"paramName": "actionType", "paramValue": "click", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "convOfferId",
    "displayName": "Offer ID (optional)",
    "simpleValueType": true,
    "help": "Everflow Offer ID. Either Offer ID or Advertiser ID is required for conversion tracking.",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "advertiserId",
    "displayName": "Advertiser ID (optional)",
    "simpleValueType": true,
    "help": "Everflow Advertiser ID. Used when you want to attribute conversions across all offers for this advertiser.",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "transactionId",
    "displayName": "Transaction ID (optional)",
    "simpleValueType": true,
    "help": "The Everflow transaction ID from the click cookie. Improves attribution accuracy. Use a variable that reads the transaction ID.",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "amount",
    "displayName": "Amount (optional)",
    "simpleValueType": true,
    "help": "Sale/revenue amount for Revenue Per Sale offers.",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "orderId",
    "displayName": "Order ID (optional)",
    "simpleValueType": true,
    "help": "Unique order or transaction reference ID.",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "couponCode",
    "displayName": "Coupon code (optional)",
    "simpleValueType": true,
    "help": "Promotional or coupon code used in the order.",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "eventId",
    "displayName": "Event ID (optional)",
    "simpleValueType": true,
    "help": "Numeric event identifier for post-conversion events (upsells, registrations, etc.).",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "TEXT",
    "name": "advEventId",
    "displayName": "Advertiser Event ID (optional)",
    "simpleValueType": true,
    "help": "Global advertiser event identifier.",
    "enablingConditions": [{"paramName": "actionType", "paramValue": "conversion", "type": "EQUALS"}]
  },
  {
    "type": "GROUP",
    "name": "debugging",
    "displayName": "Debugging",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {"type": "CHECKBOX", "name": "debug", "checkboxText": "Log debug messages to console", "simpleValueType": true}
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

var log = require('logToConsole');
var injectScript = require('injectScript');
var callInWindow = require('callInWindow');
var copyFromWindow = require('copyFromWindow');
var setInWindow = require('setInWindow');
var makeString = require('makeString');
var makeNumber = require('makeNumber');
var makeInteger = require('makeInteger');

var enableDebug = data.debug;
var debugLog = function(msg) {
  if (enableDebug) log('Everflow GTM - ' + msg);
};

var trackingDomain = makeString(data.trackingDomain);
var scriptUrl = 'https://' + trackingDomain + '/scripts/sdk/everflow.js';
var actionType = data.actionType;

debugLog('Action: ' + actionType + ', Domain: ' + trackingDomain);

injectScript(scriptUrl, function() {
  debugLog('SDK loaded');

  if (actionType === 'click') {
    var clickParams = {
      offer_id: makeInteger(data.offerId),
      affiliate_id: makeInteger(data.affiliateId)
    };

    debugLog('Click: offer=' + clickParams.offer_id + ', affiliate=' + clickParams.affiliate_id);
    callInWindow('EF.click', clickParams);
    data.gtmOnSuccess();

  } else if (actionType === 'conversion') {
    var convParams = {};

    if (data.convOfferId) convParams.offer_id = makeInteger(data.convOfferId);
    if (data.advertiserId) convParams.aid = makeInteger(data.advertiserId);
    if (data.transactionId) convParams.transaction_id = makeString(data.transactionId);
    if (data.amount) convParams.amount = makeNumber(data.amount);
    if (data.orderId) convParams.order_id = makeString(data.orderId);
    if (data.couponCode) convParams.coupon_code = makeString(data.couponCode);
    if (data.eventId) convParams.event_id = makeInteger(data.eventId);
    if (data.advEventId) convParams.adv_event_id = makeInteger(data.advEventId);

    debugLog('Firing conversion for order: ' + makeString(data.orderId || 'N/A'));
    callInWindow('EF.conversion', convParams);
    data.gtmOnSuccess();

  } else {
    debugLog('Unknown action type');
    data.gtmOnFailure();
  }

}, function() {
  debugLog('SDK failed to load from ' + scriptUrl);
  data.gtmOnFailure();
}, 'everflow-sdk');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "vpiVersion": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://*.everflow.io/scripts/sdk/everflow.js"
              },
              {
                "type": 1,
                "string": "https://*.everflow.io/scripts/main.js"
              },
              {
                "type": 1,
                "string": "https://*/scripts/sdk/everflow.js"
              },
              {
                "type": 1,
                "string": "https://*/scripts/main.js"
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
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "vpiVersion": "1"
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
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "EF"},
                  {"type": 8, "boolean": true},
                  {"type": 8, "boolean": true},
                  {"type": 8, "boolean": false}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "EF.click"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "EF.conversion"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
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
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "vpiVersion": "1"
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
  }
]


___TESTS___

scenarios:
- name: "Click tracking loads SDK and fires click"
  code: |-
    var mockData = {
      actionType: 'click',
      trackingDomain: 'www.example-tracking.com',
      offerId: '42',
      affiliateId: '7',
      debug: false
    };

    mock('injectScript', function(url, success, failure, token) {
      success();
    });

    mock('callInWindow', function() {});

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();
- name: "Conversion tracking with amount and order ID"
  code: |-
    var mockData = {
      actionType: 'conversion',
      trackingDomain: 'www.example-tracking.com',
      convOfferId: '42',
      amount: '29.99',
      orderId: 'ORD-12345',
      couponCode: 'SAVE10',
      debug: false
    };

    mock('injectScript', function(url, success, failure, token) {
      success();
    });

    mock('callInWindow', function() {});

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();
- name: "Conversion tracking with advertiser ID"
  code: |-
    var mockData = {
      actionType: 'conversion',
      trackingDomain: 'www.example-tracking.com',
      advertiserId: '5',
      amount: '49.99',
      transactionId: 'abc123def',
      debug: true
    };

    mock('injectScript', function(url, success, failure, token) {
      success();
    });

    mock('callInWindow', function() {});

    runCode(mockData);
    assertApi('gtmOnSuccess').wasCalled();
- name: "SDK load failure calls gtmOnFailure"
  code: |-
    var mockData = {
      actionType: 'click',
      trackingDomain: 'www.example-tracking.com',
      offerId: '42',
      affiliateId: '7',
      debug: false
    };

    mock('injectScript', function(url, success, failure, token) {
      failure();
    });

    runCode(mockData);
    assertApi('gtmOnFailure').wasCalled();


___NOTES___

Created on 2026-04-04 by New North Digital (newnorth.digital).
