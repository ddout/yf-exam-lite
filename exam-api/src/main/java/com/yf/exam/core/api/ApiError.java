package com.yf.exam.core.api;


import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 全局错误码定义，用于定义接口的响应数据，
 * 枚举名称全部使用代码命名，在系统中调用，免去取名难的问题。
 * @author bool 
 * @date 2019-06-14 21:15
 */
@NoArgsConstructor
@AllArgsConstructor
public enum ApiError implements Serializable {


    /**
     * 通用错误，接口参数不全
     */
    ERROR_10010001("参数不全或类型错误！"),
    ERROR_10010002("您还未登录，请先登录！"),
    ERROR_10010003("数据不存在！"),
    ERROR_10010012("图形验证码错误！"),
    ERROR_10010013("短信验证码错误！"),
    ERROR_10010014("不允许重复评论！"),


    ERROR_20010001("用户不存在！"),
    ERROR_20010002("手机号或密码错误！"),
    ERROR_20010003("注册手机号已存在！"),
    ERROR_20010004("旧手机验证码错误！"),
    ERROR_20010005("新绑定的手机号已存在！"),
    ERROR_20010006("积分余额不足，请充值！"),
    ERROR_20010007("VIP暂不支持购买！"),
    ERROR_20010008("首次登录必须完善手机！"),
    ERROR_20010009("社交账号已经被绑定过！"),


    /**
     * 拍卖相关的错误
     */
    ERROR_30000001("商品拍卖已结束！"),
    ERROR_30000002("当前拍卖已结束，请关注下期！"),
    ERROR_30000003("竞拍不存在，请确认！"),
    ERROR_30000004("竞拍还未结束，不能下单！"),
    ERROR_30000005("您还没有资格进行此购买！"),
    ERROR_30000006("不允许重复下单！"),
    ERROR_30000007("您正在参与自动竞拍，无需重复操作！"),
    ERROR_30000008("参与记录不存在！"),
    ERROR_30000009("您已经在领先位置！"),
    ERROR_30000010("下手慢了，被抢拍！"),


    ERROR_40000001("一个订单至少要包含一件商品！"),
    ERROR_40000002("商品库存不足！"),
    ERROR_40000003("商品已下架！"),
    ERROR_40000004("用户收货地址为空！"),
    ERROR_40000005("暂无物流信息！"),
    ERROR_40000006("快递查询接口出现异常！"),
    ERROR_40000007("支付宝下单出现异常！"),
    ERROR_40000008("订单状态错误！"),
    ERROR_40000009("订单类型错误，应为：vip/mall/auction"),
    ERROR_40000010("SKU定位失败！"),
    ERROR_40000011("退款出现异常！"),
    ERROR_40000012("订单通知出现异常！"),

    ERROR_40000013("第三方处理退款出现异常！"),




    ERROR_90010001("管理员账号不存在！"),
    ERROR_90010002("账号或密码错误！"),
    ERROR_90010003("至少要包含一个角色！"),
    ERROR_90010004("管理员账号无法修改！"),
    ERROR_90010005("账号被禁用，请联系管理员！"),
    ERROR_90010006("活动用户不足，无法开启竞拍！"),


    ERROR_60000001("数据不存在！");

    public String msg;

    /**
     * 生成Markdown格式文档，用于更新文档用的
     * @param args
     */
    public static void main(String[] args) {
        for (ApiError e : ApiError.values()) {
            System.out.println("'"+e.name().replace("ERROR_", "")+"':'"+e.msg+"',");
        }
    }

    /**
     * 获取错误码
     * @return
     */
    public Integer getCode(){
        return Integer.parseInt(this.name().replace("ERROR_", ""));
    }
}
