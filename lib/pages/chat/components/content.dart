import 'package:chat_gui/components/markdown_renderer.dart';
import 'package:chat_gui/pages/chat/controller.dart';
import 'package:chat_gui/utils/cxxxr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:md_single_block_renderer/md_single_block_renderer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ChatContent extends GetView<ChatScreenController> {
  final int tabletWidth;
  const ChatContent({super.key, required this.tabletWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Align(
        alignment: Alignment.topCenter,
        child: Obx(
          () => SelectionArea(
            child: ListView.separated(
              reverse: true,
              padding: EdgeInsets.zero,
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.testMdBlocks.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints:
                        tabletWidth > 0
                            ? BoxConstraints(maxWidth: tabletWidth.toDouble())
                            : BoxConstraints(),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: MarkdownSingleBlockRenderer(
                            controller.testMdBlocks[controller.testMdBlocks.length -
                                index -
                                1],
                            baseTextStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            onTapLink: (url) {
                              print(url);
                              launchUrlString(url);
                            },
                          ),
                        );
                        // if (index == 0) {
                        //   return Obx(
                        //     () => ChatContentAssistantBubble(
                        //       constraints,
                        //       controller.testStreamMd.value,
                        //     ),
                        //   );
                        // }
                        // if (index % 2 == 0) {
                        //   return ChatContentUserBubble(constraints);
                        // } else {
                        //   return ChatContentAssistantBubble(constraints, testMd);
                        // }
                      },
                    ),
                  ),
                );
              },
              separatorBuilder:
                  (context, index) => Container(color: Colors.red, height: 0),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatContentUserBubble extends GetView<ChatScreenController> {
  const ChatContentUserBubble(this.constraints, {super.key});

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.75),
          decoration: BoxDecoration(
            color: C.g1.r,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            "User Message",
            style: TextStyle(color: C.black.r, fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}

class ChatContentAssistantBubble extends GetView<ChatScreenController> {
  const ChatContentAssistantBubble(this.constraints, this.text, {super.key});

  final BoxConstraints constraints;
  final String text;

  @override
  Widget build(BuildContext context) {
    print("Building Assistant Bubble");
    return SelectionArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        // child: MarkdownRenderer(text),
      ),
    );
  }
}

class ChatContentActionButtons extends GetView<ChatScreenController> {
  const ChatContentActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
    );
  }
}

const testMd = r'''## 二级标题

### 三级标题

#### 四级标题

##### 五级标题

###### 六级标题

这是一段普通文字：

予观夫巴陵胜状，在洞庭一湖。衔远山，吞长江，浩浩汤汤，横无际涯；朝晖夕阴，气象万千。此则岳阳楼之大观也，前人之述备矣。然则北通巫峡，南极潇湘，迁客骚人，多会于此，览物之情，得无异乎？若夫霪雨霏霏，连月不开，阴风怒号，浊浪排空；日星隐曜，山岳潜形；商旅不行，樯倾楫摧；薄暮冥冥，虎啸猿啼。登斯楼也，则有去国怀乡，忧谗畏讥，满目萧然，感极而悲者矣。至若春和景明，波澜不惊，上下天光，一碧万顷；沙鸥翔集，锦鳞游泳；岸芷汀兰，郁郁青青。而或长烟一空，皓月千里，浮光跃金，静影沉璧，渔歌互答，此乐何极！登斯楼也，则有心旷神怡，宠辱偕忘，把酒临风，其喜洋洋者矣。

这是**加粗**，*斜体*，~~删除线~~，[链接](https://blog.imalan.cn)。

这是块引用与嵌套块引用：

> 安得广厦千万间，大庇天下寒士俱欢颜！风雨不动安如山。
> > 呜呼！何时眼前突兀见此屋，吾庐独破受冻死亦足！

这是行内代码：`int a=1;`。这是代码块：

```c++
int main(int argc , char** argv){
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    std::cout << "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";<< "Hello World!\n";
    return 0;
}
```

这是无序列表：

* 苹果
    * 红将军
    * 元帅
* 香蕉
* 梨

这是有序列表：

1. 打开冰箱
    1. 右手放在冰箱门拉手上
    2. 左手扶住冰箱主体
    3. 右手向后用力
2. 把大象放进冰箱
3. 关上冰箱

这是行内公式：$m\times n$，这是块级公式：

$C_{m\times k}=A_{m\times n}\cdot B_{n\times k}$

这是一张图片：

![1fa0f7b958d4234db58eac4f75318d7b.jpeg](https://cdn.imalan.cn/img/post/2934349b033b5bb5a19efc7233d3d539b700bcf5.jpg)

这是表格：

第一格表头 | 第二格表头
--------- | -------------
内容单元格 第一列第一格 | 内容单元格第二列第一格
内容单元格 第一列第二格 多加文字 | 内容单元格第二列第二格

水平分割线[^这是脚注]：

------
''';
