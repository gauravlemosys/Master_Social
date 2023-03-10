import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';

class HtmlWidget extends StatelessWidget {
  final String? postContent;
  final Color? color;

  HtmlWidget({this.postContent, this.color});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: postContent!,
      onLinkTap: (s, _, __, ___) {
        log(s);
      },
      onImageTap: (s, _, __, ___) {
        print(s);
      },
      style: {
        "table": Style(backgroundColor: color ?? transparentColor),
        "tr": Style(border: Border(bottom: BorderSide(color: Colors.black45.withOpacity(0.5)))),
        "th": Style(padding: EdgeInsets.all(6), backgroundColor: Colors.black45.withOpacity(0.5)),
        "td": Style(padding: EdgeInsets.all(6), alignment: Alignment.center),
        'embed': Style(color: color ?? transparentColor, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: FontSize(16)),
        'strong': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'a': Style(color: color ?? Colors.blue, fontWeight: FontWeight.bold, fontSize: FontSize(16)),
        'div': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'figure': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16), padding: EdgeInsets.zero, margin: EdgeInsets.zero),
        'h1': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h2': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h3': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h4': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h5': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'h6': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'p': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(14), textAlign: TextAlign.justify),
        'ol': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'ul': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'strike': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'u': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'b': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'i': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'hr': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'header': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'code': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'data': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'body': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'big': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'blockquote': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'audio': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(16)),
        'img': Style(padding: EdgeInsets.only(bottom: 8), fontSize: FontSize(14)),
        'li': Style(
          color: color ?? textPrimaryColorGlobal,
          fontSize: FontSize(16),
          listStyleType: ListStyleType.DISC,
          listStylePosition: ListStylePosition.OUTSIDE,
        ),
      },
      customRender: {
        "img": (RenderContext renderContext, Widget child) {
          String img = '';
          if (renderContext.tree.attributes.containsKey('src')) {
            img = renderContext.tree.attributes['src']!;
            log(img);
          } else if (renderContext.tree.attributes.containsKey('data-src')) {
            img = renderContext.tree.attributes['data-src']!;
          }
          return CachedNetworkImage(
            imageUrl: img,
            width: context.width(),
            height: 220,
            fit: BoxFit.cover,
          ).cornerRadiusWithClipRRect(defaultRadius).onTap(() {
            //
          });
        },
        "p": (RenderContext renderContext, Widget child) {
          return Text(renderContext.tree.element!.text.validate(), style: secondaryTextStyle(size: 16), textAlign: TextAlign.justify);
        },
      },
    );
  }
}
