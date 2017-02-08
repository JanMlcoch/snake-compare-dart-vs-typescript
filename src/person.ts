/**
 * Created by Crat on 07.02.2017.
 */
interface Person {
    name: string;
    age: number;
}

function birthday(someone : Person) : Person {
    const watafa = someone.age;
    return {name: someone.name, age: someone.age+1};
}

console.dir(birthday({name:"Judy",age:39}));