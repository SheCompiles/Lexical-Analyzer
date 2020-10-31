#include <iostream>
#include <sstream>
#include <cstring>
#include <string>
#include <algorithm>
#include <cctype>
using namespace std;


//creates key with length of text
string keygen(string key, string text){
  while(key.length() < text.length()){
    for (int i = 0; i < key.length(); i++) {
      if(key.length() == text.length())
      break;
      key += (key[i]);
    }
  }
  return key;
}

int whiteSpace(string text, int c){
  c = 0; //count number of whitespace
  for(int i = 0; i < text.length(); i++){
    if(isspace(text[i])){
      c++;
    }
  }
  return c;
}

//encrypts plaintext message
string vigenereEn(string key, string text){
	string cipher_text;
  //swapping whitespace with s
	for (int i = 0; i < text.size(); i++)
	{
      if(text[i] == ' '){
      text[i] = 's';
      }
		// converting in range 0-25
		char x = (text[i] + key[i]) %26;

		// convert into alphabets(ASCII)
		x += 'A';

		cipher_text.push_back(x);
	}
	return cipher_text;
}

//decrypts cipher to plaintext
string vigenereDe(string key, string cipher){
	string plaintext;

	for (int i = 0 ; i < cipher.size(); i++)
	{
		// converting in range 0-25
		char x = (cipher[i] - key[i] + 26) %26;

		// convert into alphabets(ASCII)
		x += 'A';
		plaintext.push_back(x);
	}
	return plaintext;
}

string swapSpace(string de, int c, int white[]){
    int y;
    for(int i = 0; i < c; i++){
        y = white[i];
        de[y] = ' ';
    }
    return de;
}

int main(){

string key;
string text;

cout << "Enter keyword (uppercase only | no special characters or space): ";
getline(cin, key);
cout << "\nEnter Message you want to encrypt(uppercase only | no special characters): ";
getline(cin, text);

int count;
int c = whiteSpace(text, count);
int white[c];
  char w;
  int j;
  for(int i = 0; i < text.length(); i++){
    w = text[i];
    if(isspace(w)){
      white[j] = i;
      j++;
    }
  }

string k = keygen(key, text);
cout << "\nkey: " <<k << "\n";
cout <<"original plain-text message: " <<text << '\n';
string messageEN = vigenereEn(k, text);
cout << "encrypted message: " << messageEN << "\n";
string messageDE = vigenereDe(k, messageEN);
string final = swapSpace(messageDE, c, white);
cout << "decrypted message: " << final << "\n";


}
