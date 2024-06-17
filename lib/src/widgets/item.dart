import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/util.dart';

/// [Item]
class Item extends StatelessWidget {
  final Country? country;
  final bool showFlag;
  final bool? useEmoji;
  final TextStyle? textStyle;
  final bool withCountryNames;
  final double? leadingPadding;
  final bool trailingSpace;
  final bool showSeparator;
  final BorderSide? separatorBorderSide;
  final bool isShowSelectorArrow;

  const Item({
    Key? key,
    this.country,
    this.showFlag = false,
    this.useEmoji,
    this.textStyle,
    this.withCountryNames = false,
    this.leadingPadding = 12,
    this.trailingSpace = true, this.showSeparator = false, this.separatorBorderSide, this.isShowSelectorArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dialCode = (country?.dialCode ?? '');
    if (trailingSpace && showFlag) {
      dialCode = dialCode.padRight(5, "");
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(width: leadingPadding),
          if(showFlag) _Flag(
            country: country,
            showFlag: showFlag,
            useEmoji: useEmoji,
          ),
          if(showFlag) SizedBox(width: 5.0),
          Text(
            '$dialCode',
            textDirection: TextDirection.ltr,
            style: textStyle,
          ),
          if(isShowSelectorArrow) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 20,
              color: Colors.black,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: showSeparator ? Border(
              right: separatorBorderSide ?? BorderSide.none
          ) : null
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;


  const _Flag({Key? key, this.country, this.showFlag, this.useEmoji,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null && showFlag!
        ? Container(
            child: useEmoji!
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headline5,
                  )
                : Image.asset(
                    country!.flagUri,
                    width: 32.0,
                    package: 'intl_phone_number_input',
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox.shrink();
                    },
                  ),
          )
        : SizedBox.shrink();
  }
}
