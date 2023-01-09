//
//  LoginResponeMockData.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public extension CredentialResponse {
  static func createDummyData() -> Data {
    let jsonString = """
    {
        "code": 200,
        "message": "ログインしました",
        "data": {
            "id": "3008997e38386694590f2bff",
            "username": "trang.htm_neo-lab.vn",
            "name": "Ho Thi My Trang",
            "token": "BCQn3z2V5aHQF2A4-jTFLg",
            "php_token": "eyJhbGciOiJIUzI1NiJ9.eyJzdGFmZl9jb2RlIjoiMSIsImNvbXBhbnlfY29kZSI6IjMwMTE4OCJ9.3MPBIBsYPm9UCq_2_PaJZLFFquQ_dl37eWrb_E4-s64",
            "shop_id": "df1e83bc383866c2b8f26236",
            "shop_name": "Shop 100",
            "shop_abbre_name": "1",
            "company_id": "30080ee63838661ad3875905",
            "max_break_time": 10,
            "employment_rule": {
                "id": "5ec5fcddd312e41794120a6c",
                "name": "trang",
                "code": "trang",
                "display_order": 0,
                "start_night_time": 1672711200,
                "end_night_time": 1672830000,
                "date_type_night_time": 2,
                "time_change_day_status": 1,
                "time_change_day_hour": 11,
                "time_change_day_minute": 0,
                "cutoff_date": 2,
                "user_mail": [
                    "3008997e38386694590f2bff"
                ],
                "approve_user_mail": [],
                "staff_alert": 1,
                "staff_mail": 1,
                "manager_alert": 1,
                "manager_mail": 1,
                "management_shift": {
                    "id": "5ec5fcddd312e41794120a71",
                    "round_type": 0,
                    "attend": 10,
                    "attend_type": 0,
                    "clock_out": 10,
                    "clock_out_type": 0,
                    "break1": 10,
                    "break1_type": 0,
                    "break2": 10,
                    "break2_type": 0,
                    "leave": 10,
                    "leave_type": 0,
                    "back": 10,
                    "back_type": 0
                },
                "gps_enable": true,
                "out_going": 1,
                "add_out_going": 1,
                "late_mode": {
                    "manager": true,
                    "staff": true
                },
                "late_options": [
                    "1",
                    "2",
                    "3",
                    "4"
                ],
                "night_mode_time": {
                    "hour_from": 8,
                    "minute_from": 0,
                    "hour_to": 17,
                    "minute_to": 59
                },
                "actived_smile_function": true,
                "round": {
                    "day_month": 0,
                    "month_time": 0,
                    "month_type": 0,
                    "start_time": true,
                    "end_time": false,
                    "indirect": false,
                    "outdirect": false
                },
                "has_rule_ot": 1,
                "st_working_hour": 1,
                "st_overtime_hour": 0,
                "max_break": 2,
                "setting_comment": 1,
                "m_setting_comment": 1,
                "eateries_mode": 1,
                "meal_times": 1,
                "meal_name_1": "AS1",
                "meal_price_1": 10,
                "meal_name_2": "AS2",
                "meal_price_2": 20,
                "type_cost": 1,
                "night_mode": 1,
                "black_over_time": true,
                "blind_setting": {
                    "timecard": 1,
                    "dayoff": true,
                    "conversion": true,
                    "compensatory": true,
                    "special_holiday": true
                },
                "request_time_card": true,
                "auto_accept_ot": true,
                "auto_checkout": {
                    "status": 1,
                    "hour": 17,
                    "hour_only_server": 17,
                    "minute": 0
                },
                "auto_checkout_hour": 26,
                "setting_alerts": [
                    {
                        "id": "5ec5fcddd312e41794120a6e",
                        "type": 1,
                        "status": 1,
                        "name": "not_checkout",
                        "value": 0.0,
                        "value_1": 0.0,
                        "value_2": null,
                        "value_3": null,
                        "value_4": null,
                        "type_alert_to": 0,
                        "display_order": 0
                    }
                ],
                "staff": {
                    "alert": 1,
                    "mail": 1
                },
                "manager": {
                    "alert": 1,
                    "mail": 1
                },
                "approve_staff": {
                    "alert_status": true,
                    "alert": 1,
                    "mail": 1
                },
                "approve_manager": {
                    "alert_status": true,
                    "alert": 1,
                    "mail": 0,
                    "mails": 1
                },
                "blind_setting_dayoff_all": true,
                "blind_setting_dayoff": true,
                "blind_setting_conversion": true,
                "blind_setting_compensatory": true,
                "blind_setting_special_holiday": true,
                "night_mode_edit": 1,
                "early_mode": {
                    "manager": true,
                    "staff": true
                },
                "early_options": [
                    "1",
                    "2",
                    "3"
                ],
                "require_file": true,
                "working_holiday_status": true,
                "working_holiday_conversion": true,
                "working_holiday_overtime": false,
                "input_shift": true,
                "limit_check_in": 10,
                "working_holiday_overtime_status": false,
                "calc_start_wday": 1,
                "break_calc_setting": 0,
                "overtime_calculate_mode": 1,
                "round_by_half_day_off": 0,
                "round_by_time_off": 0,
                "holiday_work_plan_calc": false,
                "compen_conver_plan_subtract": false,
                "inverval_work_status": 1,
                "cross_week_calc": true,
                "st_data_minus_day_off_half": false,
                "st_cal_working_normal": false,
                "calc_pubhol_to_wday": false,
                "mb_order_setting": {
                    " 3": "深夜労働時間",
                    " 0": "普通労働時間",
                    " 1": "所定休日労働時間",
                    " 2": "法定休日労働時間",
                    " 4": "法定内残業時間"
                },
                "st_cutoff": true,
                "inverval_work": "19:00",
                "start_night_time_settings": "11:00",
                "end_night_time_settings": "20:00",
                "night_time_status": 1,
                "night_mode_time_edit": {
                    "hour_from": 8,
                    "minute_from": 0,
                    "hour_to": 17,
                    "minute_to": 59
                },
                "break_status": true,
                "break_devices": [
                    "1",
                    "2"
                ],
                "check_in_status": true,
                "check_in_devices": [
                    "1",
                    "2"
                ],
                "indirect_status": true,
                "indirect_devices": [
                    "1",
                    "2"
                ],
                "out_going_devices": [
                    "1",
                    "2"
                ],
                "request_fix_time_card": true,
                "request_over_time": false,
                "request_day_off": true,
                "request_shift": true,
                "request_over_time_minute": 1,
                "working_holiday_minute": 1,
                "cal_law_holiday": false,
                "alert_shift": true,
                "stamp_classification": true,
                "stamp_classification_mode": true,
                "setting_stamp_classification_ids": [
                    "6108d489d312e450dcd76eb1",
                    "6108d489d312e450dcd76eb3",
                    "6108d489d312e450dcd76eb4",
                    "6108d489d312e450dcd76eb5",
                    "6108d489d312e450dcd76eb6",
                    "6108d489d312e450dcd76eb7",
                    "6108d489d312e450dcd76eb8"
                ],
                "setting_stamp_classifications": [
                    {
                        "code": 3,
                        "name": "打刻区分3",
                        "id": "6108d489d312e450dcd76eb1"
                    },
                    {
                        "code": 5,
                        "name": "namnamnamnamnamnamnamnamnamnamnamnamnamnamnamnatra",
                        "id": "6108d489d312e450dcd76eb3"
                    },
                    {
                        "code": 6,
                        "name": "sau",
                        "id": "6108d489d312e450dcd76eb4"
                    },
                    {
                        "code": 7,
                        "name": "bay",
                        "id": "6108d489d312e450dcd76eb5"
                    },
                    {
                        "code": 8,
                        "name": "tan",
                        "id": "6108d489d312e450dcd76eb6"
                    },
                    {
                        "code": 9,
                        "name": "chin",
                        "id": "6108d489d312e450dcd76eb7"
                    },
                    {
                        "code": 10,
                        "name": "muoi",
                        "id": "6108d489d312e450dcd76eb8"
                    }
                ],
                "stamp_classification_staff": true,
                "gps_time_card_request": true,
                "working_time_confirm": true,
                "check_in_by_real": true,
                "check_in_by_input": false,
                "setting_format_staff_infos": [
                    {
                        "name": "デフォルト",
                        "id": "5f3ca77ad312e410464a06e7",
                        "code": 1
                    }
                ],
                "setting_format_staff_months": [
                    {
                        "name": "デフォルト",
                        "id": "5f3dd80dd312e41536bb88af",
                        "code": 1
                    }
                ],
                "setting_format_staff_info_id": "5f3ca77ad312e410464a06e7",
                "setting_format_staff_month_id": "5f3dd80dd312e41536bb88af",
                "annual_leave_time_unit": 15,
                "conversion_leave_time_unit": 30,
                "compensatory_leave_time_unit": 10,
                "special_leave_time_unit": 10
            }
        }
    }
    """
    return Data(jsonString.utf8)
  }
}
