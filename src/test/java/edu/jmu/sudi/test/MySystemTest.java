package edu.jmu.sudi.test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import edu.jmu.sudi.entity.UserEntity;
import edu.jmu.sudi.service.DeliverService;
import edu.jmu.sudi.service.FoodService;
import edu.jmu.sudi.service.UserService;
import edu.jmu.sudi.utils.CreateCodeUtil;
import edu.jmu.sudi.utils.TemplateUtil;
import edu.jmu.sudi.utils.UUIDUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
//用配置文件形式
@ContextConfiguration({"classpath:applicationContext-dao.xml",
                        "classpath:applicationContext-service.xml",
                        "classpath:SqlMapConfig.xml"
                        })
public class MySystemTest {

    @Autowired
    private UserService userService;
    @Autowired
    private DeliverService deliverService;
    @Autowired
    private FoodService foodService;

    /**
     * 测试删除用户
     */
    @Test
    public void test1(){
        Map<String, Object> map = userService.deleteUser((long) 14);
        System.out.println(map);
    }

    /**
     * 测试自动生成配送员编号
     */
    @Test
    public void test2(){
        //2020 1131 9150 3370
        //2020 1114 1504 5354
        //2020111610132217
        //2020111610150820
        //2020111610152351
        System.out.println(CreateCodeUtil.createDeliverId());
    }

    /**
     * 测试UUID怎么用
     */
    @Test
    public void test3(){
        //2a78f1a2-5b60-434b-b72b-71ad37027d6b
        //4edce847a7fd4852bc95ec0c792cdf1f
        System.out.println(UUIDUtil.randomUUID());
    }

    /**
     * 查找配送员的三个最大值
     */
    @Test
    public void test4(){
        Map<String, Object> max = deliverService.findMax();
        System.out.println(max);
    }

    /**
     * 测试模板引擎
     */
    @Test
    public void test5(){
        //Map<String, Object> userByUserId = userService.findUserByUserId(1l);
        //System.out.println(JSON.toJSONString(userByUserId));
    }

    /**
     * 菜品SKU生成测试
     */
    @Test
    public void test6(){
        String str = "{\"foodData\":{\"foodId\":\"\",\"foodName\":\"asd\",\"typeId\":\"3\",\"foodVegon\":\"素菜\",\"foodCookWay\":\"sda\",\"recommend\":\"2\",\"hotSale\":\"2\",\"foodIngredient\":\"asd\",\"foodImage\":\"food/defaultImage/defaultImage.png\",\"foodDesc\":\"das\",\"foodattrId\":\"6\",\"foodvalueName\":\"\"},\"foodParam\":[{\"attrId\":\"5\",\"foodvalueArr\":[{\"foodvalueName\":\"辣\"},{\"foodvalueName\":\"不辣\"},{\"foodvalueName\":\"特辣\"}]},{\"attrId\":\"6\",\"foodvalueArr\":[{\"foodvalueName\":\"大份\"},{\"foodvalueName\":\"中份\"},{\"foodvalueName\":\"小份\"},{\"foodvalueName\":\"mini\"}]}]}";
        JSONObject jsonObject = JSONObject.parseObject(str);
        JSONArray foodParam = jsonObject.getJSONArray("foodParam");
        List<Map<String, Object>> foodParamList = JSON.parseObject(foodParam.toString(), new TypeReference<List<Map<String, Object>>>() {});
        foodService.generateSku(foodParamList, 1l, "牛肉");
    }

    /**
     * 测试自动生成订单编号
     */
    @Test
    public void test7(){
        String orderId = CreateCodeUtil.createOrderId();
        //D 20201204 154659 98283
        //D 20201204 154730 57201
        //D 20201204 154756 81797
        System.out.println(orderId);
    }
}
