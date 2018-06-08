#include <iostream>
#include <string>

class Animal
{
private:
    unsigned int m_numbers_of_wings;
    unsigned int m_numbers_of_legs;
protected:
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
        // these are Animal's private, so we can't use them
        //m_numbers_of_wings = 0;
        //m_numbers_of_legs = 2;
        // but we can call add_legs...
        /*this->*/add_legs(1);
        // and we could call the original add_wings like this:
        //Animal::add_wings(10);
        // but here we don't do that since regular humans have
        // 0 wings.
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

    // the following *could* look like Ada's Animal (Karl_Marx).Add_Wings (2),
    // but indeed it calls again the add_wings overridden by Human.
    //dynamic_cast<Animal*>(&karl_marx)->add_wings(2);
    // this one, instead, works
    karl_marx.Animal::add_wings(2);
    std::cout << karl_marx.wings() << " wings\n";    
    return 0;
}
