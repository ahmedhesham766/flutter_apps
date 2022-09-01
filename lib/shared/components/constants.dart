//search
// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca
import '../../modules/shop_app/shop_login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signout(context) {
Cache_Helper.removeData(key: 'token',).
then((value) {
    if(value!)
    {
    navigateandfinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? cache_token = '';

String? uid = '';