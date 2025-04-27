package domain;

/**
 *
 * @author Hong Jie
 */
public class Staff {
    private String staffId;
    private String staffName;
    private String position;
    private String phone;
    private String email;
    private double salary;
    private String password;

    // Constructor
    public Staff() {}

    public Staff(String staffId, String staffName, String phone, String email, String password, String position, double salary) {
    this.staffId = staffId;
    this.staffName = staffName;
    this.phone = phone;
    this.email = email;
    this.password = password;
    this.position = position;
    this.salary = salary;
    }

    // Getter and Setter
    public String getStaffId() {
        return staffId;
    }
    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
    public String getStaffName() {
        return staffName;
    }
    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }
    public String getPosition() {
        return position;
    }
    public void setPosition(String position) {
        this.position = position;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public double getSalary() {
        return salary;
    }
    public void setSalary(double salary) {
        this.salary = salary;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}
