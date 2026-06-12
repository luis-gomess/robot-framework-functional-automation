*** Variables ***
#messages
${MSG001}    Email Address already exist!

#data
${random}=    Generate Random String    5    [LOWER]
${default_domain}    @email.com
${default_password}    Test@123
${first_name}    John
${last_name}    Doe
${company}    Automation
${address1}    Street 1
${address2}    Apartment 101
${country}    Canada
${state}    Ontario
${city}    Toronto
${zipcode}    12345
${mobile}    11999999999
${day}    10
${month}    5
${year}    1995

#content
${signup_page_title}    New User Signup!
