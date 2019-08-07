package com.sliver.controller.index;

import com.sliver.common.pojo.BBSResult;
import com.sliver.common.pojo.YeePay;
import com.sliver.common.utils.IDUtils;
import com.sliver.common.utils.PaymentUtil;
import com.sliver.pojo.Orders;
import com.sliver.pojo.User;
import com.sliver.service.OrdersService;
import com.sliver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 订单控制器
 * @author LIN
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    @Value("${p1_MerId}")
    private String p1_MerId;

    @Value("${keyValue}")
    private String keyValue;

    @Value("${responseURL}")
    private String responseURL;

    @Value("${onlinePaymentReqURL}")
    private String onlinePaymentReqURL;

    @Autowired
    private OrdersService ordersService;
    @Autowired
    private UserService userService;

    @RequestMapping("/toRecharge")
    public String toRecharge(){
        return "user/scoreManage/addScore";
    }
    @RequestMapping("/pay")
    public String pay(Orders order, HttpServletResponse response, HttpServletRequest request) throws Exception{
        String oid = IDUtils.getUUID();
        if(order.getScore() / 10 > order.getMoney()){
             request.setAttribute("result",BBSResult.build(555,"充值失败！"));
             return "user/msg";
        }
        order.setOrderId(oid);
        ordersService.insert(order);
        response.sendRedirect(buildYeePayUrl("", oid,  order.getMoney().toString()));
        return null;
    }

    /**
     *
     * @param pd_FrpId 银行代码
     * @param p2_Order 订单号
     * @param p3_Amt 金额
     * @return
     */
    private String  buildYeePayUrl(String pd_FrpId, String p2_Order, String p3_Amt){
        // 组织发送支付公司需要哪些数据
        String p0_Cmd = "Buy";
        String p1_MerId = this.p1_MerId;
        String p4_Cur = "CNY";
        String p5_Pid = "";
        String p6_Pcat = "";
        String p7_Pdesc = "";
        // 支付成功回调地址 ---- 第三方支付公司会访问、用户访问
        // 第三方支付可以访问网址
        String p8_Url = this.responseURL;
        String p9_SAF = "";
        String pa_MP = "";
        String pr_NeedResponse = "1";
        // 加密hmac 需要密钥
        String keyValue = this.keyValue;
        String hmac = PaymentUtil.buildHmac(p0_Cmd, p1_MerId, p2_Order, p3_Amt,
                p4_Cur, p5_Pid, p6_Pcat, p7_Pdesc, p8_Url, p9_SAF, pa_MP,
                pd_FrpId, pr_NeedResponse, keyValue);

        //发送给第三方
        StringBuffer sb = new StringBuffer(onlinePaymentReqURL);
        sb.append("p0_Cmd=").append(p0_Cmd).append("&");
        sb.append("p1_MerId=").append(p1_MerId).append("&");
        sb.append("p2_Order=").append(p2_Order).append("&");
        sb.append("p3_Amt=").append(p3_Amt).append("&");
        sb.append("p4_Cur=").append(p4_Cur).append("&");
        sb.append("p5_Pid=").append(p5_Pid).append("&");
        sb.append("p6_Pcat=").append(p6_Pcat).append("&");
        sb.append("p7_Pdesc=").append(p7_Pdesc).append("&");
        sb.append("p8_Url=").append(p8_Url).append("&");
        sb.append("p9_SAF=").append(p9_SAF).append("&");
        sb.append("pa_MP=").append(pa_MP).append("&");
        sb.append("pd_FrpId=").append(pd_FrpId).append("&");
        sb.append("pr_NeedResponse=").append(pr_NeedResponse).append("&");
        sb.append("hmac=").append(hmac);
        return sb.toString();
    }

    /**
     * 付款后回调函数
     * @param session
     * @param yeePay
     * @param response
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/callback")
    public String callback(HttpSession session,YeePay yeePay, HttpServletResponse response, HttpServletRequest request)
            throws Exception{
        User logUser = (User)session.getAttribute("logUser");
        String keyValue = this.keyValue;
        String msg = "充值成功";
        // 自己对上面数据进行加密 --- 比较支付公司发过来hamc
        boolean isValid = PaymentUtil.verifyCallback(yeePay,keyValue);
        if (isValid) {
            // 响应数据有效
            if (yeePay.getR9_BType().equals("1")) {
                // 浏览器重定向
                System.out.println("111");

            } else if (yeePay.getR9_BType().equals("2")) {
                // 服务器点对点 --- 支付公司通知你
                System.out.println("付款成功！222");
                // 修改订单状态 为已付款
                // 回复支付公司
                response.getWriter().print("success");
            }

            //修改订单状态
            Orders orders = new Orders();
            orders.setOrderId(yeePay.getR6_Order());
            orders.setFinished(true);
            int i = ordersService.finishOrders(orders);
            if(i == 0){
                 msg = "充值失败！请重试";
                 request.setAttribute("result",BBSResult.build(555,msg));
                 return "user/msg";
            }
            logUser = userService.getUserById(logUser.getId());
            session.setAttribute("logUser",logUser);

        } else {
            // 数据无效
            System.out.println("数据被篡改！");
            msg = "充值失败！请重试";
            request.setAttribute("result",BBSResult.build(555,msg));
            return "user/msg";
        }
        request.setAttribute("result",BBSResult.ok());
        return "user/msg";
    }
}
