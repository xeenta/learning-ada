#include <iostream>
#include <string>

class Animal
{
protected:
    unsigned int m_numbers_of_wings;
    unsigned int m_numbers_of_legs;
    
    // derived classes can make an instance; this isn't exactly like Ada.
    Animal() : m_numbers_of_wings(0), m_numbers_of_legs(0) {}
    // but the following wouldn't make it work!
    //Animal() = delete;
public:
    virtual ~Animal() {}
    virtual unsigned int legs() const {
        return m_numbers_of_legs;
    }
    virtual unsigned int wings() const {
        return m_numbers_of_wings;
    }
    virtual void add_legs(unsigned int n) {
        m_numbers_of_legs += 2 * n;
    }
    virtual void add_wings(unsigned int n) {
        m_numbers_of_wings += 2 * n;
    }
};

class Human : public Animal
{
public:
    enum class Sex { Male, Female, Unknown };

    Human(const std::string& name, const Sex sex)
        : m_name(name), m_sex(sex) {
        m_numbers_of_wings = 0;
        m_numbers_of_legs = 2;
    }
    virtual ~Human() {};
    // mad scientists don't add wings to human...
    virtual void add_wings(unsigned int n) override {}
    virtual std::string get_name() const { return m_name; }
    virtual Sex get_sex() const { return m_sex; }
private:
    std::string m_name;
    Sex m_sex;
};


int main()
{
    Human karl_marx("Karl Marx", Human::Sex::Male);
    std::cout << karl_marx.get_name()
              << ", "
              << (karl_marx.get_sex() == Human::Sex::Male ? "MALE" : "FEMALE")
              << ":\n"
              << karl_marx.legs() << " legs\n"
              << karl_marx.wings() << " wings\n";

    karl_marx.add_legs(1);
    karl_marx.add_wings(2);
    std::cout << karl_marx.legs() << " legs\n"
              << karl_marx.wings() << " wings\n";

    karl_marx.Animal::add_wings(2);
    std::cout << karl_marx.wings() << " wings\n";    
    return 0;
}
