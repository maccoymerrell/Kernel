struct s{
    int a;
    struct s *b, *c;
};

int f(struct s* c){
    int x = 0;
    struct s* cs = c;
    while(cs != 0){
        x = x + f(cs->b) + cs->a;
        cs = cs->c;
    }
    return(x);
}

int main(){
    struct s a;
    a.a = 1;
    a.b = 0;
    a.c = 0;

    struct s b;
    b.a = 2;
    b.b = 0;
    b.c = 0;

    struct s c;
    c.a = 3;
    c.b = &a;
    c.c = &b;

    int x = f(&c);
    printf("%i\n",x);
}