#!/usr/bin/env python3

from pyquery import PyQuery  # install using `pip install pyquery`
import json

################################### CONFIGURATION ###################################
location_id = "294e1ac420e35622f2a093ac2951485fa4c28cd2fe5b8a01da513a1b2bb809ca"

# celcius or fahrenheit
unit = "metric"  # metric or imperial

# forcase type
forecast_type = "Hourly" # Hourly or Daily

########################################## MAIN ##################################

# get html page
_l = "en-IN" if unit == "metric" else "en-US"
url = f"https://weather.com/{_l}/weather/today/l/{location_id}"

# get html data
html_data = PyQuery(url=url)

# current temperature
temp = html_data("span[data-testid='TemperatureValue']").eq(0).text()

# status code
status_code_class = html_data("#regionHeader").attr("class")
status_code = str(status_code_class).split(" ")[2].split("-")[2]

# min-max temperature
temp_min = (
    html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
    .eq(1)
    .text()
)
temp_max = (
    html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
    .eq(0)
    .text()
)

out_data = {
    "text": f"  {temp}C",
    "tooltip": f"Min: {temp_min}C\nMax: {temp_max}C",
    "class": status_code,
}
print(json.dumps(out_data))