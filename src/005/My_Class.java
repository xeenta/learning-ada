class My_Class
{
    public int Counter;
    public int Id;

    public My_Class(int p_Id) {
        // implementation
        this.Counter = p_Id * 2 + 1;
        this.Id = p_Id + 1;
    }

    static public void main(String[] args) {
        My_Class m = new My_Class(10);
        System.out.println(m.Counter);
        System.out.println(m.Id);
    }
};
