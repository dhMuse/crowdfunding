json.title @campaign.title
json.details @campaign.details
json.target @campaign.target
json.end_date @campaign.end_date.strftime("%Y-%B-%d")