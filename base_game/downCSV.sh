#!/bin/bash

#Téléchargement BDD .csv

url_dl="https://modules-api.etna-alternance.net/7754/activities/42370/download/FDI-UNIX/025/project/The%20Hyrule%20Castle/public/csv/races.csv"
token_etna="eyJpZGVudGl0eSI6ImV5SnBaQ0k2TXpJM056RXNJbXh2WjJsdUlqb2ljRzkxYm5sZmFpSXNJbVZ0WVdsc0lqb2ljRzkxYm5sZmFrQmxkRzVoTFdGc2RHVnlibUZ1WTJVdWJtVjBJaXdpYkc5bllYTWlPbVpoYkhObExDSm5jbTkxY0hNaU9sc2ljM1IxWkdWdWRDSmRMQ0pzYjJkcGJsOWtZWFJsSWpvaU1qQXlNUzB3TXkweE1pQXhOVG8wT1RveU1DSjkiLCJzaWduYXR1cmUiOiIxTzlCaE9YTXVLYStNTWtKbDU5cVpZcmhEV09kS3lnV1hQWFlLZW9LSDZQbEFXM3hneURaTmpDXC9kTjVzaTlIMTFDcnAxSlpiM21WMUxHcG1TN1cyWlZxVFM5XC8xZkYxazVFblFHbTBwNzJjT0FqTFdWQmRMRFkrYzloNVBYejlPQm5LeEd4VTNseWxKVW52RTl1emt6MG5rMEVMeGpaTEplVVh3SjMxamhxK3UrZ1V5bDF5Y1kyVUlVdEFVbldwR0UyNlNrZFJTcTZwTWtGMlpDWFwvKzZTVnRKRE1nOFd5UWhcL3Q0ZEdDQ2g1dlhNaXBzK2ZOVHh2MjdcL3Bzb3JcL1pWbzdWMmxnTTV5R2QrYzVqZFFFQndVVWFQcTZTbmVldVwvMUdpSXI1XC9FaGd2ekxcL0hCMG9yeDNsa1BlbWEyYWFzbjQ3ekIrZUlYWFQwNFkwTG5mQytWM1MwR1hXZXRvcndsQUdBRVBtd0ZhYnQrYUFHSHZPNmV5TnpTbGpVNGZPSlZJeGcydEE1eHlpTDF6RHI0Vk1ERFwvNVVPQzNDTWh2M1pOYjRcL29aWFRDVGZRdUU5QU04Slg4U2xPKzlTYUUybTY3NEtMdUE3UGphVTM3OTZlbUV5TzMzS2tpNXV4MkV6S2F4R294OGZjaWVJZXNVcUpyaVF3djVcL0dKbmhlcGI3N3pDNU9CZlBWTk1wV05uUVczRVB2TUZ1UEZmeVdRTk5lQ0E4WUR0SHlhd1V5dGRhbnZzUFwvbDRYa2k1dWE3OGN3RHhLV0laOVU4UzU4Sksxd0VoZVk5UFkzc1FtOXNsV0lNeXNHVlRweWUreGs2K3NyQ2FTMU1xRGh6UmRsclJnaitncGJcL3Z1UWszZWU3c0J3c05qcnNSQ1RBR0FhdlNmNlY3V1dnRGpMUW4wPSJ9"

wget -q --header "Cookie:authenticator=$token_etna" $url_dl
