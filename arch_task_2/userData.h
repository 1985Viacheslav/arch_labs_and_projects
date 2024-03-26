#include <iostream>

struct UserData {
    int id;
    std::string login;
    std::string first_name;
    std::string last_name;

    UserData() : id(0) {}

    void clear() {
        id = 0;
        login.clear();
        first_name.clear();
        last_name.clear();
    }
};
