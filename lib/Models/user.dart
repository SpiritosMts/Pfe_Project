final name = 'Souid Houssem';
final email = 'souid780@gmail.com';
final urlImage = 'https://scontent.ftun14-1.fna.fbcdn.net/v/t39.30808-6/275417114_3241791546144852_5581031544389275396_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=hSWyTmRoQYMAX-FufvF&_nc_ht=scontent.ftun14-1.fna&oh=00_AT8Azl8beURxBRERr2Uum6kj1PPPypdqybeM1l3YuIA9kw&oe=62ABE6F7';

class AppUser {

  String id;
  String name;
  String phone;
  String? email;
  String? pwd;
  String? address;
  String? isChan;

  AppUser({
    this.id = 'no-id',
    this.email = 'no-email',
    this.name = 'no-name',
    this.pwd  = 'no-pwd',
    this.phone  = 'no-phone',
    this.address  = 'no-address',
    this.isChan  = 'false',

  });
}
