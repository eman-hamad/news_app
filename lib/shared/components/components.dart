import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: article['urlToImage'] == null
                      ? AssetImage('assets/images/placeholder.png')
                      : NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildListDivider() => Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      width: double.infinity,
      height: 0.9,
      color: Colors.grey[350],
    ));

Widget itemBuilder(list, context, {isInSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      //or  condition: state is! NewsGetSportsLoadingState
      fallback: (contex) => isInSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (BuildContext context, int index) =>
              buildListDivider(),
          itemCount: list.length),
    );

Widget defaultFormField(
        {@required TextEditingController controller,
        @required TextInputType type,
        @required String text,
        Function onSubmit,
        Function onChange,
        @required Function validate,
        Function onTap,
        @required IconData prefix,
        IconData suffix,
        bool isPassword = false,
        bool isClickable = false,
        Function suffixpressed,
        Color fillColor,
        bool isFilled}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,

      // or obscureText: isPassword ? true: false ,
      // means : isPassword have a value or not
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        fillColor: fillColor,
        filled: isFilled,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
      ),
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,

      readOnly: isClickable,
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
