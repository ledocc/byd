byd__package__add_id(
    NAME Poco
    URL "https://pocoproject.org/"
    MAINTAINER "David Callu callu.david@gmail.com"
    )

byd__package__add_dependency_constraint(Poco OpenSSL VERSION_GREATER_EQUAL 1.0.2)
byd__package__add_dependency_constraint(Poco zip VERSION_GREATER_EQUAL 2.6.7)
