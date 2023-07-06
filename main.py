import json
import requests
import platform
import flet as ft

BASE_URL = "193.200.130.200:81"
if platform.system() == 'Windows':
    BASE_URL = "localhost"


def province_page(page, province_name):
    """绑定参数"""
    temp_text_input = ft.Text(value=province_name, size=40, color=ft.colors.BLUE)
    button_temp = ft.TextButton(
        width=200,
        height=200,
        content=ft.Row(
            [
                temp_text_input,
            ],
            alignment=ft.MainAxisAlignment.SPACE_AROUND,
        ),
        on_click=lambda _: page.go(f"/city/{province_name}"), data=0
    )
    return button_temp


def city_page(page, city_name, stationid, province_name):
    """绑定参数"""
    temp_text_input = ft.Text(value=city_name, size=40, color=ft.colors.BLUE)
    button_temp = ft.TextButton(
        width=200,
        height=200,
        content=ft.Row(
            [
                temp_text_input,
            ],
            alignment=ft.MainAxisAlignment.SPACE_AROUND,
        ),
        on_click=lambda _: page.go(f"/station/{stationid}/{province_name}/{city_name}"), data=0
    )
    return button_temp


def index_provience_list(page: ft.Page):
    temp_list = [ft.AppBar(title=ft.Text("免费天气数据"), bgcolor=ft.colors.SURFACE_VARIANT)]
    r = ft.Row(wrap=True, scroll="always", expand=True)
    for i in json.loads(requests.get(f"http://{BASE_URL}/province").text).get("data").get("list"):
        r.controls.append(
            ft.Container(province_page(page, i.get("name")),
                         width=225,
                         height=190,
                         alignment=ft.alignment.center,
                         bgcolor=ft.colors.AMBER_100,
                         border=ft.border.all(1, ft.colors.AMBER_400),
                         border_radius=ft.border_radius.all(5),
                         )
        )
    temp_list.append(r)
    return temp_list


def city_list_by_provience(page: ft.Page):
    temp_list = [ft.AppBar(title=ft.Text(page.route.split("/city/")[-1]), bgcolor=ft.colors.SURFACE_VARIANT),
                 ft.ElevatedButton("返回", on_click=lambda _: page.go("/"))]
    r = ft.Row(wrap=True, scroll="always", expand=True)
    for i in json.loads(
            requests.get(f'http://{BASE_URL}/freeapi/v1/city?province_name={page.route.split("/city/")[-1]}').text).get(
        "data"):
        r.controls.append(
            ft.Container(city_page(page, i.get("city"), i.get("stationid"), page.route.split("/city/")[-1]),
                         width=225,
                         height=190,
                         alignment=ft.alignment.center,
                         bgcolor=ft.colors.AMBER_100,
                         border=ft.border.all(1, ft.colors.AMBER_400),
                         border_radius=ft.border_radius.all(5),
                         )
        )
    temp_list.append(r)
    return temp_list


def city_detail_feature(resp_data_dact):
    # 未来天气
    rows_feature = []
    for i in resp_data_dact.get("list2"):
        rows_feature.append(ft.DataRow(
            cells=[
                ft.DataCell(ft.Text(f"{i.get('Date')}")),
                ft.DataCell(ft.Text(f"白天")),
                ft.DataCell(ft.Text(f"{i.get('Day_info')}")),
                ft.DataCell(ft.Text(f"{i.get('Day_temperature')}")),
                ft.DataCell(ft.Text(f"{i.get('Day_direct')}")),
                ft.DataCell(ft.Text(f"{i.get('Day_power')}")),
                ft.DataCell(ft.Text(f"夜间")),
                ft.DataCell(ft.Text(f"{i.get('Night_info')}")),
                ft.DataCell(ft.Text(f"{i.get('Night_temperature')}")),
                ft.DataCell(ft.Text(f"{i.get('Night_direct')}")),
                ft.DataCell(ft.Text(f"{i.get('Night_power')}")),
            ],
        ))
    #     r.controls.append(
    #         ft.Container(city_page(page, i.get("city"), i.get("stationid")),
    #                      width=225,
    #                      height=190,
    #                      alignment=ft.alignment.center,
    #                      bgcolor=ft.colors.AMBER_100,
    #                      border=ft.border.all(1, ft.colors.AMBER_400),
    #                      border_radius=ft.border_radius.all(5),
    #                      )
    #     )
    return ft.DataTable(
        columns=[
            ft.DataColumn(ft.Text("未来天气")),
            ft.DataColumn(ft.Text("白天")),
            ft.DataColumn(ft.Text("天气")),
            ft.DataColumn(ft.Text("温度")),
            ft.DataColumn(ft.Text("风向")),
            ft.DataColumn(ft.Text("风力")),
            ft.DataColumn(ft.Text("夜间")),
            ft.DataColumn(ft.Text("天气")),
            ft.DataColumn(ft.Text("温度")),
            ft.DataColumn(ft.Text("风向")),
            ft.DataColumn(ft.Text("风力")),
            # ft.DataColumn(ft.Text("Age"), numeric=True),
        ],
        rows=rows_feature,
    )


def city_detail_history(resp_data_dact):
    # 历史数据
    rows_old = []
    for i in resp_data_dact.get("list3"):
        rows_old.append(ft.DataRow(
            cells=[
                ft.DataCell(ft.Text(f"{i.get('Date')}")),
                ft.DataCell(ft.Text(f"白天")),
                ft.DataCell(ft.Text(f"{i.get('Day_info')}")),
                ft.DataCell(ft.Text(f"{i.get('Day_temperature')}")),
                ft.DataCell(ft.Text(f"{i.get('Day_direct')}")),
                ft.DataCell(ft.Text(f"{i.get('Day_power')}")),
                ft.DataCell(ft.Text(f"夜间")),
                ft.DataCell(ft.Text(f"{i.get('Night_info')}")),
                ft.DataCell(ft.Text(f"{i.get('Night_temperature')}")),
                ft.DataCell(ft.Text(f"{i.get('Night_direct')}")),
                ft.DataCell(ft.Text(f"{i.get('Night_power')}")),
            ],
        ))
    #     r.controls.append(
    #         ft.Container(city_page(page, i.get("city"), i.get("stationid")),
    #                      width=225,
    #                      height=190,
    #                      alignment=ft.alignment.center,
    #                      bgcolor=ft.colors.AMBER_100,
    #                      border=ft.border.all(1, ft.colors.AMBER_400),
    #                      border_radius=ft.border_radius.all(5),
    #                      )
    #     )
    return ft.DataTable(
        columns=[
            ft.DataColumn(ft.Text("历史天气")),
            ft.DataColumn(ft.Text("白天")),
            ft.DataColumn(ft.Text("天气")),
            ft.DataColumn(ft.Text("温度")),
            ft.DataColumn(ft.Text("风向")),
            ft.DataColumn(ft.Text("风力")),
            ft.DataColumn(ft.Text("夜间")),
            ft.DataColumn(ft.Text("天气")),
            ft.DataColumn(ft.Text("温度")),
            ft.DataColumn(ft.Text("风向")),
            ft.DataColumn(ft.Text("风力")),
            # ft.DataColumn(ft.Text("Age"), numeric=True),
        ],
        rows=rows_old,
    )


def city_detail_hour(resp_data_dact):
    # 历史数据
    rows_old = []
    for i in resp_data_dact.get("list0"):
        rows_old.append(ft.DataRow(
            cells=[
                ft.DataCell(ft.Text(f"{i.get('Time')}")),
                ft.DataCell(ft.Text(f"{i.get('Info')}")),
                ft.DataCell(ft.Text(f"{i.get('Temperature')}")),
                ft.DataCell(ft.Text(f"{i.get('Humidity')}")),
                ft.DataCell(ft.Text(f"{i.get('Rain')}")),
                ft.DataCell(ft.Text(f"{i.get('Wind_direct')}")),
                ft.DataCell(ft.Text(f"{i.get('Wind_speed')}")),
            ],
        ))
    return ft.DataTable(
        columns=[
            ft.DataColumn(ft.Text("分时预测")),
            ft.DataColumn(ft.Text("天气")),
            ft.DataColumn(ft.Text("温度")),
            ft.DataColumn(ft.Text("湿度")),
            ft.DataColumn(ft.Text("降雨量mm")),
            ft.DataColumn(ft.Text("风向")),
            ft.DataColumn(ft.Text("风速m/s")),
        ],
        rows=rows_old,
    )


def city_detail_now(resp_data_dact):
    # 历史数据
    rows_now = []
    for i in resp_data_dact.get("list1"):
        rows_now.append(ft.DataRow(
            cells=[
                ft.DataCell(ft.Text(f"{i.get('Time')}")),
                ft.DataCell(ft.Text(f"{i.get('Info')}")),
                ft.DataCell(ft.Text(f"{i.get('Temperature')}")),
                ft.DataCell(ft.Text(f"{i.get('Feelst')}")),
                ft.DataCell(ft.Text(f"{i.get('Icomfort')}")),
                ft.DataCell(ft.Text(f"{i.get('Rain')}")),
                ft.DataCell(ft.Text(f"{i.get('Wind_power')}")),
                ft.DataCell(ft.Text(f"{i.get('Wind_speed')}")),
                ft.DataCell(ft.Text(f"{i.get('Wind_direct')}")),
                ft.DataCell(ft.Text(f"{i.get('Aqi')}")),
                ft.DataCell(ft.Text(f"{i.get('Humidity')}")),
            ],
        ))
    return ft.DataTable(
        columns=[
            ft.DataColumn(ft.Text("实时天气")),
            ft.DataColumn(ft.Text("天气")),
            ft.DataColumn(ft.Text("温度")),
            ft.DataColumn(ft.Text("体感温度")),
            ft.DataColumn(ft.Text("舒适度")),
            ft.DataColumn(ft.Text("降雨量mm")),
            ft.DataColumn(ft.Text("风力")),
            ft.DataColumn(ft.Text("风速m/s")),
            ft.DataColumn(ft.Text("风向")),
            ft.DataColumn(ft.Text("空气质量")),
            ft.DataColumn(ft.Text("湿度")),
        ],
        rows=rows_now,
    )


def city_detail_now_warning(resp_data_dact):
    # 历史数据
    rows_now = []
    for i in resp_data_dact.get("list1"):
        rows_now.append(ft.DataRow(
            cells=[
                ft.DataCell(ft.Text(f"{i.get('Aq')}")),
            ],
        ))
        return ft.DataTable(
            columns=[
                ft.DataColumn(ft.Text("预警信息")),
            ],
            rows=rows_now,
        )
    return


def city_detail(page: ft.Page):
    temp_list = [ft.AppBar(title=ft.Text(page.route.split("/station/")[-1].split("/")[2]),
                           bgcolor=ft.colors.SURFACE_VARIANT),
                 ft.ElevatedButton("返回", on_click=lambda _: page.go(
                     f'/city/{page.route.split("/station/")[-1].split("/")[1]}'))]
    # r = ft.Row(wrap=True, scroll="always", expand=True)
    resp_data_dact = json.loads(requests.get(
        f'http://{BASE_URL}/freeapi/v1/detail?keyword={page.route.split("/station/")[-1].split("/")[0]}').text)

    temp_list.append(city_detail_now(resp_data_dact))
    temp_list.append(city_detail_now_warning(resp_data_dact))
    temp_list.append(city_detail_hour(resp_data_dact))
    temp_list.append(city_detail_feature(resp_data_dact))
    temp_list.append(city_detail_history(resp_data_dact))
    return temp_list


def main(page: ft.Page):
    page.title = "免费天气数据"

    def route_change(route):
        page.views.clear()
        page.views.append(
            ft.View(
                "/",
                index_provience_list(page),
            )
        )
        if "/city" in page.route:
            page.views.append(
                ft.View(
                    page.route,
                    city_list_by_provience(page),
                )
            )
        if "/station" in page.route:
            page.views.append(
                ft.View(
                    page.route,
                    city_detail(page),
                )
            )
        page.update()

    def view_pop(view):
        page.views.pop()
        top_view = page.views[-1]
        page.go(top_view.route)

    page.on_route_change = route_change
    page.on_view_pop = view_pop
    page.go(page.route)


# ft.app(target=main, view=ft.flet.WEB_BROWSER)
# ft.app(target=main, view=ft.WEB_BROWSER)
ft.app(name='', target=main, view=None, port=80)
