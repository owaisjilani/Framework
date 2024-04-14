*** Variables ***

# Alerts API Endpoints for Testing
${common_path}                                        /api/v1/case

${case_get_list_endpoint}                               ${common_path}/get_list
${case_get_transitions_endpoint}                        ${common_path}/get-transitions
${case_endpoint}                                        ${common_path}