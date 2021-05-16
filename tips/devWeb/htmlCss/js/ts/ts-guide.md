# TypeScript 新增特性一览

译自 [TypeScript Wiki](https://github.com/Microsoft/TypeScript/wiki/What's-new-in-TypeScript/0908f26468460e0a1fc66e9151c5971853d27140).

## TypeScript 2.6

### 严格函数类型

TypeScript 2.6 引入了新的类型检查选项, `--strictFunctionTypes`.
`--strictFunctionTypes` 选项是 `--strict` 系列选项之一, 也就是说 `--strict` 模式下它默认是启用的.
你可以通过在命令行或 tsconfig.json 中设置 `--strictFunctionTypes false` 来单独禁用它.

`--strictFunctionTypes` 启用时, 函数类型参数的检查是*逆变*（contravariantly）而非*双变*（bivariantly）的. 关于变型 (variance) 对与函数类型意义的相关背景, 请查看[协变（covariance）和逆变（contravariance）是什么?](https://www.stephanboyer.com/post/132/what-are-covariance-and-contravariance).

这一更严格的检查应用于*除*方法或构造函数声明以外的所有函数类型.
方法被专门排除在外是为了确保带泛型的类和接口（如 `Array<T>`）总体上仍然保持协变.

考虑下面这个 `Animal` 是 `Dog` 和 `Cat` 的父类型的例子:

```ts
declare let f1: (x: Animal) => void;
declare let f2: (x: Dog) => void;
declare let f3: (x: Cat) => void;
f1 = f2;  // 启用 --strictFunctionTypes 时错误
f2 = f1;  // 正确
f2 = f3;  // 错误
```

第一个赋值语句在默认的类型检查模式中是允许的, 但是在严格函数类型模式下会被标记错误.
通俗地讲, 默认模式允许这么赋值, 因为它*可能是*合理的, 而严格函数类型模式将它标记为错误, 因为它不能*被证明*合理.
任何一种模式中, 第三个赋值都是错误的, 因为它*永远不*合理.

用另一种方式来描述这个例子则是, 默认类型检查模式中 `T` 在类型 `(x: T) => void` 是*双变的* (也即协变*或*逆变), 但在严格函数类型模式中 `T` 是*逆变*的.

##### 例子

```ts
interface Comparer<T> {
    compare: (a: T, b: T) => number;
}

declare let animalComparer: Comparer<Animal>;
declare let dogComparer: Comparer<Dog>;

animalComparer = dogComparer;  // 错误
dogComparer = animalComparer;  // 正确
```

现在第一个赋值是错误的. 更明确地说, `Comparer<T>` 中的 `T` 因为仅在函数类型参数的位置被使用, 是逆变的.

另外, 注意尽管有的语言 (比如 C# 和 Scala) 要求变型标注 (variance annotations) (`out`/`in` 或 `+`/`-`), 而由于 TypeScript 的结构化类型系统, 它的变型是由泛型中的类型参数的实际使用自然得出的.

##### 注意:

启用 `--strictFunctionTypes` 时, 如果 `compare` 被声明为方法, 则第一个赋值依然是被允许的.
更明确的说, `Comparer<T>` 中的 `T` 因为仅在方法参数的位置被使用所以是双变的.

```ts
interface Comparer<T> {
    compare(a: T, b: T): number;
}

declare let animalComparer: Comparer<Animal>;
declare let dogComparer: Comparer<Dog>;

animalComparer = dogComparer;  // 正确, 因为双变
dogComparer = animalComparer;  // 正确
```

TypeScript 2.6 还改进了与逆变位置相关的类型推导:

```ts
function combine<T>(...funcs: ((x: T) => void)[]): (x: T) => void {
    return x => {
        for (const f of funcs) f(x);
    }
}

function animalFunc(x: Animal) {}
function dogFunc(x: Dog) {}

let combined = combine(animalFunc, dogFunc);  // (x: Dog) => void
```

这上面所有 `T` 的推断都来自逆变的位置, 由此我们得出 `T` 的*最普遍子类型*.
这与从协变位置推导出的结果恰恰相反, 从协变位置我们得出的是*最普遍超类型*.

### 缓存模块中的标签模板对象

TypeScript 2.6 修复了标签字符串模板的输出, 以更好地遵循 ECMAScript 标准.
根据 [ECMAScript 标准](https://tc39.github.io/ecma262/#sec-gettemplateobject), 每一次获取模板标签的值时, 应该将*同一个*模板字符串数组对象 (同一个 `TemplateStringArray`) 作为第一个参数传递.
在 TypeScript 2.6 之前, 每一次生成的都是全新的模板对象.
虽然字符串的内容是一样的, 这样的输出会影响通过识别字符串来实现缓存失效的库, 比如 [lit-html](https://github.com/PolymerLabs/lit-html/issues/58).

##### 例子

```ts
export function id(x: TemplateStringsArray) {
    return x;
}

export function templateObjectFactory() {
    return id`hello world`;
}

let result = templateObjectFactory() === templateObjectFactory(); // TS 2.6 为 true
```

编译后的代码:

```js
"use strict";
var __makeTemplateObject = (this && this.__makeTemplateObject) || function (cooked, raw) {
    if (Object.defineProperty) { Object.defineProperty(cooked, "raw", { value: raw }); } else { cooked.raw = raw; }
    return cooked;
};

function id(x) {
    return x;
}

var _a;
function templateObjectFactory() {
    return id(_a || (_a = __makeTemplateObject(["hello world"], ["hello world"])));
}

var result = templateObjectFactory() === templateObjectFactory();
```

> 注意: 这一改变引入了新的工具函数, `__makeTemplateObject`;
如果你在搭配使用 `--importHelpers` 和 [`tslib`](https://github.com/Microsoft/tslib), 需要更新到 1.8 或更高版本.

### 本地化的命令行诊断消息

TypeScript 2.6 npm 包加入了 13 种语言的诊断消息本地化版本.
命令行中本地化消息会在使用 `--locale` 选项时显示.

##### 例子

俄语显示的错误消息:

```sh
c:\ts>tsc --v
Version 2.6.1

c:\ts>tsc --locale ru --pretty c:\test\a.ts

../test/a.ts(1,5): error TS2322: Тип ""string"" не может быть назначен для типа "number".

1 var x: number = "string";
      ~
```

中文显示的帮助信息:

```sh
PS C:\ts> tsc --v
Version 2.6.1

PS C:\ts> tsc --locale zh-cn
版本 2.6.1
语法: tsc [选项] [文件 ...]

示例: tsc hello.ts
    tsc --outFile file.js file.ts
    tsc @args.txt

选项:
 -h, --help                    打印此消息。
 --all                         显示所有编译器选项。
 -v, --version                 打印编译器的版本。
 --init                        初始化 TypeScript 项目并创建 tsconfig.json 文件。
 -p 文件或目录, --project 文件或目录     编译给定了其配置文件路径或带 "tsconfig.json" 的文件夹路径的项目。
 --pretty                      使用颜色和上下文风格化错误和消息(实验)。
 -w, --watch                   监视输入文件。
 -t 版本, --target 版本            指定 ECMAScript 目标版本: "ES3"(默认)、"ES5"、"ES2015"、"ES2016"、"ES2017" 或 "ESNEXT"。
 -m 种类, --module 种类            指定模块代码生成: "none"、"commonjs"、"amd"、"system"、"umd"、"es2015"或 "ESNext"。
 --lib                         指定要在编译中包括的库文件:
                                 'es5' 'es6' 'es2015' 'es7' 'es2016' 'es2017' 'esnext' 'dom' 'dom.iterable' 'webworker' 'scripthost' 'es2015.core' 'es2015.collection' 'es2015.generator' 'es2015.iterable' 'es2015.promise' 'es2015.proxy' 'es2015.reflect' 'es2015.symbol' 'es2015.symbol.wellknown' 'es2016.array.include' 'es2017.object' 'es2017.sharedmemory' 'es2017.string' 'es2017.intl' 'esnext.asynciterable'
 --allowJs                     允许编译 JavaScript 文件。
 --jsx 种类                      指定 JSX 代码生成: "preserve"、"react-native" 或 "react"。 -d, --declaration             生成相应的 ".d.ts" 文件。
 --sourceMap                   生成相应的 ".map" 文件。
 --outFile 文件                  连接输出并将其发出到单个文件。
 --outDir 目录                   将输出结构重定向到目录。
 --removeComments              请勿将注释发出到输出。
 --noEmit                      请勿发出输出。
 --strict                      启用所有严格类型检查选项。
 --noImplicitAny               对具有隐式 "any" 类型的表达式和声明引发错误。
 --strictNullChecks            启用严格的 NULL 检查。
 --strictFunctionTypes         对函数类型启用严格检查。
 --noImplicitThis              在带隐式“any" 类型的 "this" 表达式上引发错误。
 --alwaysStrict                以严格模式进行分析，并为每个源文件发出 "use strict" 指令。
 --noUnusedLocals              报告未使用的局部变量上的错误。
 --noUnusedParameters          报告未使用的参数上的错误。
 --noImplicitReturns           在函数中的所有代码路径并非都返回值时报告错误。
 --noFallthroughCasesInSwitch  报告 switch 语句中遇到 fallthrough 情况的错误。
 --types                       要包含在编译中类型声明文件。
 @<文件>                         从文件插入命令行选项和文件。
```

### 通过 '// @ts-ignore' 注释隐藏 .ts 文件中的错误

TypeScript 2.6 支持在 .ts 文件中通过在报错一行上方使用 `// @ts-ignore` 来忽略错误.

##### 例子

```ts
if (false) {
    // @ts-ignore: 无法被执行的代码的错误
    console.log("hello");
}
```

`// @ts-ignore` 注释会忽略下一行中产生的所有错误.
建议实践中在 `@ts-ignore` 之后添加相关提示, 解释忽略了什么错误.

请注意, 这个注释仅会隐藏报错, 并且我们建议你*极少*使用这一注释.

### 更快的 `tsc --watch`

TypeScript 2.6 带来了更快的 `--watch` 实现.
新版本优化了使用 ES 模块的代码的生成和检查.
在一个模块文件中检测到的改变*只*会使改变的模块, 以及依赖它的文件被重新生成, 而不再是整个项目.
有大量文件的项目应该从这一改变中获益最多.

这一新的实现也为 tsserver 中的监听带来了性能提升.
监听逻辑被完全重写以更快响应改变事件.

### 只写的引用现在会被标记未使用

TypeScript 2.6 加入了修正的 `--noUnusedLocals` 和 `--noUnusedParameters` [编译选项](https://www.typescriptlang.org/docs/handbook/compiler-options.html)实现.
只被写但从没有被读的声明现在会被标记未使用.

##### 例子

下面 `n` 和 `m` 都会被标记为未使用, 因为它们的值从未被*读取*. 之前 TypeScript 只会检查它们的值是否被*引用*.

```ts
function f(n: number) {
    n = 0;
}

class C {
    private m: number;
    constructor() {
        this.m = 0;
    }
}
```

另外仅被自己内部调用的函数也会被认为是未使用的.

##### 例子

```ts
function f() {
    f(); // 错误: 'f' 被声明, 但它的值从未被使用
}
```

## TypeScript 2.5

### 可选的 `catch` 语句变量

得益于 [@tinganho](https://github.com/tinganho) 做的工作, TypeScript 2.5 实现了一个新的 ECMAScript 特性, 允许用户省略 `catch` 语句中的变量.
举例来说, 当使用 `JSON.parse` 时, 你可能需要将对应的函数调用放在 `try`/`catch` 中, 但是最后可能并不会用到输入有误时会抛出的 `SyntaxError` (语法错误).

```ts
let input = "...";
try {
    JSON.parse(input);
}
catch {
    // ^ 注意我们的 `catch` 语句并没有声明一个变量
    console.log("传入的 JSON 不合法\n\n" + input)
}
```

### `checkJs`/`@ts-check` 模式中的类型断言/转换语法

TypeScript 2.5 引入了[在使用纯 JavaScript 的项目中断言表达式类型](https://github.com/Microsoft/TypeScript/issues/5158)的能力.
对应的语法是 `/** @type {...} */` 标注注释后加上被圆括号括起来, 类型需要被重新演算的表达式.
举例:

```ts
var x = /** @type {SomeType} */ (AnyParenthesizedExpression);
```

### 包去重和重定向

在 TypeScript 2.5 中使用 `Node` 模块解析策略进行导入时, 编译器现在会检查文件是否来自 "相同" 的包.
如果一个文件所在的包的 `package.json` 包含了与之前读取的包相同的 `name` 和 `version`, 那么 TypeScript 会将它重定向到最顶层的包.
这可以解决两个包可能会包含相同的类声明, 但因为包含 `private` 成员导致他们在结构上不兼容的问题.

这也带来一个额外的好处, 可以通过避免从重复的包中加载 `.d.ts` 文件减少内存使用和编译器及语言服务的运行时计算.

### `--preserveSymlinks` (保留符号链接) 编译器选项

TypeScript 2.5 带来了 `preserveSymlinks` 选项, 它对应了 [Node.js 中 `--preserve-symlinks` 选项](https://nodejs.org/api/cli.html#cli_preserve_symlinks)的行为.
这一选项也会带来和 Webpack 的 `resolve.symlinks` 选项相反的行为 (也就是说, 将 TypeScript 的 `preserveSymlinks` 选项设置为 `true` 对应了将 Webpack 的 `resolve.symlinks` 选项设为 `false`, 反之亦然).

在这一模式中, 对于模块和包的引用 (比如 `import` 语句和 `/// <reference type="..." />` 指令) 都会以相对符号链接文件的位置被解析, 而不是相对于符号链接解析到的路径.
更具体的例子, 可以参考 [Node.js 网站的文档](https://nodejs.org/api/cli.html#cli_preserve_symlinks).

## TypeScript 2.4

### 动态导入 (import) 表达式

动态 `import` 表达式是 ECMAScript 的新特性之一, 它让用户可以在程序的任意位置异步地请求一个模块.

这意味着你可以在条件恰当的情况下延迟加载其他模块和库.
举例来说, 下面的 `async` 函数在需要的时候才会导入相应工具库:

```ts
async function getZipFile(name: string, files: File[]): Promise<File> {
    const zipUtil = await import('./utils/create-zip-file');
    const zipContents = await zipUtil.getContentAsBlob(files);
    return new File(zipContents, name);
}
```

很多打包工具支持基于这样的 `import` 表达式自动分割结果, 所以可以考虑搭配 `esnext` 编译目标来使用这一新功能.

### 字符串枚举值

TypeScript 2.4 现在支持枚举成员中包含字符串初始化器.

```ts
enum Colors {
    Red = "RED",
    Green = "GREEN",
    Blue = "BLUE",
}
```

使用字符串来初始化的枚举值一个弊端是不能使用反向映射获取原来的枚举成员名称.
换句话说, 你不能通过写 `Colors["RED"]` 来获得字符串 `"Red"`.

### 改进的泛型推断

TypeScript 2.4 围绕泛型推断的方法引入了一些非常棒的变化.

#### 将返回类型作为推断目标

其一, TypeScript 现在可以对函数调用的返回值进行推断.
这可以提升你的使用体验并捕获更多错误.
一个现在可用的例子:

```ts
function arrayMap<T, U>(f: (x: T) => U): (a: T[]) => U[] {
    return a => a.map(f);
}

const lengths: (a: string[]) => number[] = arrayMap(s => s.length);
```

另一个你可能会遇上的错误的例子:

```ts
let x: Promise<string> = new Promise(resolve => {
    resolve(10);
    //      ~~ 错误!
});
```

#### 从包含上下文的类型推断类型参数

在 TypeScript 2.4 之前, 在下面的例子中:

```ts
let f: <T>(x: T) => T = y => y;
```

`y` 的类型会是 `any`.
这意味着虽然程序会进行类型检查, 但技术上讲你可以对 `y` 做任何事, 比如下面的:

```ts
let f: <T>(x: T) => T = y => y() + y.foo.bar;
```

最后一个例子并不是真正类型安全的.

在 TypeScript 2.4 中, 右侧的函数隐式地*获得了*类型参数, 然后 `y` 被推断出具有这个类型参数的类型.

如果你以类型参数的约束不允许的方式来使用 `y`, 则会像预期一样得到一个错误.
在这个例子中, 对于 `T` 的约束是 `{}` (隐式地), 所以最后一个例子会按照预期给出错误.

#### 对泛型函数更严格的检查

TypeScript 现在会在比较两个单一签名的类型时尝试去统一类型参数.
作为结果, 你会在与两个泛型签名相关的情况下获得更严格的检查, 接着或许会发现一些 bug.

```ts
type A = <T, U>(x: T, y: U) => [T, U];
type B = <S>(x: S, y: S) => [S, S];

function f(a: A, b: B) {
    a = b;  // 错误
    b = a;  // 正确
}
```

### 回调参数的严格逆变 (contravariance)

TypeScript 始终使用一个双变的 (bivariant) 方式来比较参数.
这么做有不少原因, 在过去这对我们的用户来说并不是个大问题, 直到我们看到了它在 `Promise` 和 `Observable` 的使用中带来的不利影响.

当关联两个回调类型时, TypeScript 2.4 会收紧这种比较. 举例来说:

```ts
interface Mappable<T> {
    map<U>(f: (x: T) => U): Mappable<U>;
}

declare let a: Mappable<number>;
declare let b: Mappable<string | number>;

a = b;
b = a;
```

在 TypeScript 之前, 这个例子能成功编译.
当关联 `map` 的类型时, TypeScript 会双向关联它们的参数 (也就是 `f` 的类型).
当关联每一个 `f` 时, TypeScript 又会双向关联*这些*参数的类型.

在 TS 2.4 中当关联 `map` 的类型时, 这门语言会检查是否每个参数都是回调类型, 如果是, 它会确保这些参数在考虑当前关系的情况下会以逆变的方式被检查.

换言之, TypeScript 现在可以捕获上述的 bug, 虽然这对于一些用户来说可能会是一个不兼容的改变, 但能带来的好处会更多.

### 弱类型检测

TypeScript 2.4 引入了 "弱类型" 的概念.
任何全部属性都可选的类型被认为是*弱类型*.
比如, 下面的 `Options` 类型就是一个弱类型:

```ts
interface Options {
    data?: string;
    timeout?: number;
    maxRetries?: number;
}
```

在 TypeScript 2.4 中, 把任何没有重合属性的值赋给一个弱类型将会报错.
举例来说:

```ts
function sendMessage(options: Options) {
    // ...
}

const opts = {
    payload: "hello world!",
    retryOnFail: true,
}

// 错误!
sendMessage(opts);
// 'opts' 的类型和 'Options' 间没有重合的部分.
// 或许我们是想用 'data'/'maxRetries' 而不是 'payload'/'retryOnFail'.
```

你可以把这理解为 TypeScript 增强了这些类型的羸弱的保障, 来捕获本来无法找到的 bug.

由于这是一个破坏兼容性的改变, 你可能需要知道相关的处理方法, 这里的方法和针对严格对象字面量检查的方法一样.

1. 声明确实存在的属性.
2. 为弱类型添加一个索引签名 (也就是 `[propName: string]: {}`).
3. 使用类型断言 (也就是 `opts as Options`).

## TypeScript 2.3

### ES5/ES3 的生成器和迭代支持

*首先是一些 ES2016 的术语:*

#### 迭代器

[ES2015 引入了 `Iterator` (迭代器)](http://www.ecma-international.org/ecma-262/6.0/#sec-iteration), 它表示提供了 `next`, `return`, and `throw` 三个方法的对象, 具体满足以下接口:

```ts
interface Iterator<T> {
  next(value?: any): IteratorResult<T>;
  return?(value?: any): IteratorResult<T>;
  throw?(e?: any): IteratorResult<T>;
}
```

这一类迭代器在迭代同步可用的值时很有用, 比如数组的元素或者 Map 的键.
如果一个对象有一个返回 `Iterator` 对象的 `Symbol.iterator` 方法, 那么我们说这个对象支持迭代.

迭代器的协议也定义了一些像 `for..of` 和展开运算符以及解构赋值中的数组的剩余运算的操作对象.

#### 生成器

[ES2015 也引入了 "生成器"](http://www.ecma-international.org/ecma-262/6.0/#sec-generatorfunction-objects), 生成器是可以通过 `Iterator` 接口和 `yield` 关键字被用来生成部分运算结果的函数.
生成器也可以在内部通过 `yield*` 代理对与其他可迭代对象的调用. 举例来说:

```ts
function* f() {
  yield 1;
  yield* [2, 3];
}
```

#### 新的 `--downlevelIteration` 选项

之前迭代器只在编译目标为 ES6/ES2015 或者更新版本时可用.
此外, 设计迭代器协议的结构, 比如 `for..of`, 如果编译目标低于 ES6/ES2015, 则只能在操作数组时被支持.

TypeScript 2.3 在 ES3 和 ES5 为编译目标时由 `--downlevelIteration` 选项增加了完整的对生成器和迭代器协议的支持.

通过 `--downlevelIteration` 选项, 编译器会使用新的类型检查和输出行为, 尝试调用被迭代对象的 `[Symbol.iterator]()` 方法 (如果有), 或者在对象上创建一个语义上的数组迭代器.

> 注意这需要非数组的值有原生的 `Symbol.iterator` 或者 `Symbol.iterator` 的运行时模拟实现.

使用 `--downlevelIteration` 时, 在 ES5/ES3 中 `for..of` 语句, 数组解构, 数组中的元素展开, 函数调用, new 表达式在支持 `Symbol.iterator` 时可用, 但即便没有定义 `Symbol.iterator`, 它们在运行时或开发时都可以被使用到数组上.

### 异步迭代

TypeScript 2.3 添加了对异步迭代器和生成器的支持, 描述见当前的 [TC39 提案](https://github.com/tc39/proposal-async-iteration).

#### 异步迭代器

异步迭代引入了 `AsyncIterator`, 它和 `Iterator` 相似.
实际上的区别在于 `AsyncIterator` 的 `next`, `return` 和 `throw` 方法的返回的是迭代结果的 `Promise`, 而不是结果本身. 这允许 `AsyncIterator` 在生成值之前的时间点就加入异步通知.
`AsyncIterator` 的接口如下:

```ts
interface AsyncIterator<T> {
  next(value?: any): Promise<IteratorResult<T>>;
  return?(value?: any): Promise<IteratorResult<T>>;
  throw?(e?: any): Promise<IteratorResult<T>>;
}
```

一个支持异步迭代的对象如果有一个返回 `AsyncIterator` 对象的 `Symbol.asyncIterator` 方法, 被称作是 "可迭代的".

#### 异步生成器

[异步迭代提案](https://github.com/tc39/proposal-async-iteration)引入了 "异步生成器", 也就是可以用来生成部分计算结果的异步函数. 异步生成器也可以通过 `yield*` 代理对可迭代对象或异步可迭代对象的调用:

```ts
async function* g() {
  yield 1;
  await sleep(100);
  yield* [2, 3];
  yield* (async function *() {
    await sleep(100);
    yield 4;
  })();
}
```

和生成器一样, 异步生成器只能是函数声明, 函数表达式, 或者类或对象字面量的方法. 箭头函数不能作为异步生成器. 异步生成器除了一个可用的 `Symbol.asyncIterator` 引用外 (原生或三方实现), 还需要一个可用的全局 `Promise` 实现 (既可以是原生的, 也可以是 ES2015 兼容的实现).

#### `for await..of` 语句

最后, ES2015 引入了 `for..of` 语句来迭代可迭代对象.
相似的, 异步迭代提案引入了 `for await..of` 语句来迭代可异步迭代的对象.

```ts
async function f() {
  for await (const x of g()) {
     console.log(x);
  }
}
```

`for await..of` 语句仅在异步函数或异步生成器中可用.

#### 注意事项

- 始终记住我们对于异步迭代器的支持是建立在运行时有 `Symbol.asyncIterator` 支持的基础上的.
你可能需要 `Symbol.asyncIterator` 的三方实现, 虽然对于简单的目的可以仅仅是: `(Symbol as any).asyncIterator = Symbol.asyncIterator || Symbol.from("Symbol.asyncIterator");`
- 如果你没有声明 `AsyncIterator`, 还需要在 `--lib` 选项中加入 `esnext` 来获取 `AsyncIterator` 声明.
- 最后, 如果你的编译目标是 ES5 或 ES3, 你还需要设置 `--downlevelIterators` 选项.

### 泛型参数默认类型

TypeScript 2.3 增加了对声明泛型参数默认类型的支持.

#### 例子

考虑一个会创建新的 `HTMLElement` 的函数, 调用时不加参数会生成一个 `Div`; 你也可以选择性地传入子元素的列表. 之前你必须这么去定义:

```ts
declare function create(): Container<HTMLDivElement, HTMLDivElement[]>;
declare function create<T extends HTMLElement>(element: T): Container<T, T[]>;
declare function create<T extends HTMLElement, U extends HTMLElement>(element: T, children: U[]): Container<T, U[]>;
```

有了泛型参数默认类型, 我们可以将定义化简为:

```ts
declare function create<T extends HTMLElement = HTMLDivElement, U = T[]>(element?: T, children?: U): Container<T, U>;
```

泛型参数的默认类型遵循以下规则:

- 有默认类型的类型参数被认为是可选的.
- 必选的类型参数不能在可选的类型参数后.
- 如果类型参数有约束, 类型参数的默认类型必须满足这个约束.
- 当指定类型实参时, 你只需要指定必选类型参数的类型实参. 未指定的类型参数会被解析为它们的默认类型.
- 如果指定了默认类型, 且类型推断无法选择一个候选类型, 那么将使用默认类型作为推断结果.
- 一个被现有类或接口合并的类或者接口的声明可以为现有类型参数引入默认类型.
- 一个被现有类或接口合并的类或者接口的声明可以引入新的类型参数, 只要它指定了默认类型.

### 新的 `--strict` 模板选项

TypeScript 加入的新检查项为了避免不兼容现有项目通常都是默认关闭的. 虽然避免不兼容是好事, 但这个策略的一个弊端则是使配置最高类型安全越来越复杂, 这么做每次 TypeScript 版本发布时都需要显示地加入新选项. 有了 `--strict` 选项, 就可以选择最高级别的类型安全 (了解随着更新版本的编译器增加了增强的类型检查特性可能会报新的错误).

新的 `--strict` 编译器选项包含了一些建议配置的类型检查选项. 具体来说, 指定 `--strict` 相当于是制订了以下所有选项 (未来还可能包括更多选项):

- `--strictNullChecks`
- `--noImplicitAny`
- `--noImplicitThis`
- `--alwaysStrict`

确切地说, `--strict` 选项会为以上列出的编译器选项设置*默认*值. 这意味着还可以单独控制这些选项. 比如:

```
--strict --noImplicitThis false
```

的效果是开启除了 `--noImplicitThis` 选项以外的严格检查选项. 使用这个方式可以表述除某些明确列出的项以外的*所有*严格检查项. 换句话说, 现在可以在默认最高级别的类型安全下排除部分检查.

从 TypeScript 2.3 开始, `tsc --init` 生成的默认 `tsconfig.json` 在 `"compilerOptions"` 中包含了 `"strict: true"` 设置. 这样一来, 用 `tsc --init` 创建的新项目默认会开启最高级别的类型安全.

### 改进的 `--init` 输出

除了默认的 `--strict` 设置外, `tsc --init` 还改进了输出. `tsc --init` 默认生成的 `tsconfig.json` 现在包含了一些带描述的被注释掉的常用编译器选项. 你可以去掉相关选项的注释来获得期望的结果; 我们希望新的输出能简化新项目的配置并且随着项目成长保持配置文件的可读性.

### `--checkJS` 选项下 .js 文件中的错误

即便使用了 `--allowJs`, TypeScript 编译器默认不会报 .js 文件中的任何错误. TypeScript 2.3 中使用 `--checkJs` 选项, `.js` 文件中的类型检查错误也可以被报出.

你可以通过为它们添加 `// @ts-nocheck` 注释来跳过对某些文件的检查; 反过来你也可以选择通过添加 `// @ts-check` 注释只检查一些 `.js` 文件而不需要设置 `--checkJs` 选项. 你也可以通过添加 `// @ts-ignore` 到特定行的一行前来忽略这一行的错误.

`.js` 文件仍然会被检查确保只有标准的 ECMAScript 特性; 类型标注仅在 `.ts` 文件中被允许, 在 `.js` 中会被标记为错误. JSDoc 注释可以用来为你的 JavaScript 代码添加某些类型信息, 见 [JSDoc 支持文档](https://github.com/Microsoft/TypeScript/wiki/JSDoc-support-in-JavaScript)了解更多关于支持的 JSDoc 构造的详情.

见[对 JavaScript 文件进行类型检查](https://github.com/Microsoft/TypeScript/wiki/Type-Checking-JavaScript-Files)了解更多详情.

## TypeScript 2.2

### 支持混合 (Mix-in) 类

TypeScript 2.2 增加了对 ECMAScript 2015 混合类模式 (见 [MDN 混合类的描述](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes#Mix-ins) 及 [JavaScript 类的 "真" 混合](http://justinfagnani.com/2015/12/21/real-mixins-with-javascript-classes/) 了解更多) 以及使用交叉来类型表达结合混合构造函数的签名及常规构造函数签名的规则.

#### 首先是一些术语:

- **混合构造函数类型**指仅有单个构造函数签名, 且该签名仅有一个类型为 `any[]` 的变长参数, 返回值为对象类型. 比如, 有 `X` 为对象类型, `new (...args: any[]) => X` 是一个实例类型为 `X` 的混合构造函数类型.

- **混合类**指一个 `extends` (扩展) 了类型参数类型的表达式的类声明或表达式<sup>[1]</sup>. 以下规则对混合类声明适用:
  - `extends` 表达式的类型参数类型必须是混合构造函数.
  - 混合类的构造函数 (如果有) 必须有且仅有一个类型为 `any[]` 的变长参数, 并且必须使用展开运算符在 `super(...args)` 调用中将这些参数传递.

假设有类型参数为 `T` 且约束为 `X` 的表达式 `Base`, 处理混合类 `class C extends Base {...}` 时会假设 `Base` 有 `X` 类型, 处理结果为交叉类型 `typeof C & T`. 换言之, 一个混合类被表达为混合类构造函数类型与参数基类构造函数类型的交叉类型.

在获取一个包含了混合构造函数类型的交叉类型的构造函数签名时, 混合构造函数签名会被丢弃, 而它们的实例类型会被混合到交叉类型中其他构造函数签名的返回类型中. 比如, 交叉类型 `{ new(...args: any[]) => A } & { new(s: string) => B }` 仅有一个构造函数签名 `new(s: string) => A & B`.

#### 将以上规则放到一个例子中:

```ts
class Point {
    constructor(public x: number, public y: number) {}
}

class Person {
    constructor(public name: string) {}
}

type Constructor<T> = new(...args: any[]) => T;

function Tagged<T extends Constructor<{}>>(Base: T) {
    return class extends Base {
        _tag: string;
        constructor(...args: any[]) {
            super(...args);
            this._tag = "";
        }
    }
}

const TaggedPoint = Tagged(Point);

let point = new TaggedPoint(10, 20);
point._tag = "你好";

class Customer extends Tagged(Person) {
    accountBalance: number;
}

let customer = new Customer("张三");
customer._tag = "测试";
customer.accountBalance = 0;
```

混合类可以通过在类型参数中限定构造函数签名的返回值类型来限制它们可以被混入的类的类型. 举例来说, 下面的 `WithLocation` 函数实现了一个为满足 `Point` 接口 (也就是有类型为 `number` 的 `x` 和 `y` 属性) 的类添加 `getLocation` 方法的子类工厂.

```ts
interface Point {
    x: number;
    y: number;
}

const WithLocation = <T extends Constructor<Point>>(Base: T) =>
    class extends Base {
        getLocation(): [number, number] {
            return [this.x, this.y];
        }
    }
```

### `object` 类型

TypeScript 之前没有一个用来表示非原始类型, 也就是非 `number` | `string` | `boolean` | `symbol` | `null` | `undefined` 的类型. 进入新的 `object` 类型.

有了 `object` 类型, `Object.create` 这样的 API 可以被更好地表达. 比如:

```ts
declare function create(o: object | null): void;

create({ prop: 0 }); // 正确
create(null); // 正确

create(42); // 错误
create("string"); // 错误
create(false); // 错误
create(undefined); // 错误
```

### 对 `new.target` 的支持

`new.target` 元属性是 ES2015 中引入的新语法. 当一个构造函数的实例通过 `new` 被创建时, `new.target` 被设置为到最初被用来配置这个实例的构造函数的引用. 如果一个函数是被调用而不是通过 `new` 来构造, `new.target` 则被设置为 `undefined`.

`new.target` 在类的构造函数中需要 `Object.setPrototypeOf` 或者设置 `__proto__` 时很有用. 一个具体的例子则是从 Node.js v4 及更高版本中继承 `Error`.

#### 例子

```ts
class CustomError extends Error {
    constructor(message?: string) {
        super(message); // 'Error' 会改变原型链
        Object.setPrototypeOf(this, new.target.prototype); // 恢复原型链
    }
}
```

生成的 JS

```js
var CustomError = (function (_super) {
  __extends(CustomError, _super);
  function CustomError() {
    var _newTarget = this.constructor;
    var _this = _super.apply(this, arguments);  // 'Error' 会改变原型链
    _this.__proto__ = _newTarget.prototype; // 恢复原型链
    return _this;
  }
  return CustomError;
})(Error);
```

在编写可构建的函数时, 使用 `new.target` 也很方便, 比如:

```ts
function f() {
  if (new.target) { /* 通过 'new' 来调用 */ }
}
```

会被编译为:

```js
function f() {
  var _newTarget = this && this instanceof f ? this.constructor : void 0;
  if (_newTarget) { /* 通过 'new' 来调用 */ }
}
```

### 更好地检查表达式操作数中的 `null`/`undefined`

TypeScript 2.2 改进了对表达式中可空的操作数的检查. 具体来说, 下面的例子现在会被标记为错误:

- 如果 `+` 运算符的任意操作数为可空的, 且没有任何一个操作数的类型为 `any` 或 `string`.
- 如果 `-`, `*`, `**`, `/`, `%`, `<<`, `>>`, `>>>`, `&`, `|`, 或 `^` 运算符的任意操作数为可空的.
- 如果 `<`, `>`, `<=`, `>=`, 或 `in` 运算符的任意操作数为可空的.
- 如果 `instanceof` 运算符的右操作数为可空的.
- 如果 `+`, `-`, `~`, `++`, 或 `--` 一元运算符的操作数为可空的.

如果一个操作数的类型是 `null` 或 `undefined` 或包含 `null` 或 `undefined` 的联合类型, 那么这个操作数被认为是可空的. 注意联合类型的情况只会在 `--strictNullChecks` 时存在, 因为在普通类型检查模式下 `null` 和 `undefined` 会从联合类型中消失掉.

### 有字符串索引签名类型的点属性

有字符串索引签名的类型可以使用 `[]` 符号来索引, 但之前不能使用 `.` 来访问. 从 TypeScript 2.2 开始, 两种方式都被允许.

```ts
interface StringMap<T> {
    [x: string]: T;
}

const map: StringMap<number>;

map["prop1"] = 1;
map.prop2 = 2;

```

这一项只会被应用到具备*显式*字符串索引签名的类型. 使用 `.` 符号来访问一个类型的未知属性依然会报错.

### 支持在对 JSX 子元素使用展开运算符

TypeScript 2.2 添加了对 JSX 子元素使用展开运算符的支持. 请参考 [facebook/jsx#57](https://github.com/facebook/jsx/issues/57) 了解详情.

#### 例子

```ts
function Todo(prop: { key: number, todo: string }) {
    return <div>{prop.key.toString() + prop.todo}</div>;
}

function TodoList({ todos }: TodoListProps) {
    return <div>
        {...todos.map(todo => <Todo key={todo.id} todo={todo.todo} />)}
    </div>;
}

let x: TodoListProps;

<TodoList {...x} />
```

### 新的 `jsx: react-native`

React-native 的构建过程需要所有文件的扩展名都为 `.js`, 即使这个文件包含了 JSX 语法. 新的 `--jsx` 选项值 `react-native` 将会在生成的文件中保留 JSX 语法, 但使用 `.js` 扩展名.

## TypeScript 2.1

### `keyof` 与查找类型

在 JavaScript 生态里常常会有 API 接受属性名称作为参数的情况, 但到目前为止还无法表达这类 API 的类型关系.

入口索引类型查询或者说 `keyof`;
索引类型查询 `keyof T` 会得出 `T` 可能的属性名称的类型.
`keyof T` 类型被认为是 `string` 的子类型.

##### 例子

```ts
interface Person {
    name: string;
    age: number;
    location: string;
}

type K1 = keyof Person; // "name" | "age" | "location"
type K2 = keyof Person[];  // "length" | "push" | "pop" | "concat" | ...
type K3 = keyof { [x: string]: Person };  // string
```

与之对应的是*索引访问类型*, 也叫作*查找类型 (lookup types)*.
语法上, 它们看起来和元素访问完全相似, 但是是以类型的形式使用的:

##### 例子

```ts
type P1 = Person["name"];  // string
type P2 = Person["name" | "age"];  // string | number
type P3 = string["charAt"];  // (pos: number) => string
type P4 = string[]["push"];  // (...items: string[]) => number
type P5 = string[][0];  // string
```

你可以将这种形式与类型系统中的其他功能组合, 来获得类型安全的查找.

```ts
function getProperty<T, K extends keyof T>(obj: T, key: K) {
    return obj[key];  // 推断的类型为 T[K]
}

function setProperty<T, K extends keyof T>(obj: T, key: K, value: T[K]) {
    obj[key] = value;
}

let x = { foo: 10, bar: "hello!" };

let foo = getProperty(x, "foo"); // number
let bar = getProperty(x, "bar"); // string

let oops = getProperty(x, "wargarbl"); // 错误! "wargarbl" 不满足类型 "foo" | "bar"

setProperty(x, "foo", "string"); // 错误! string 应该是 number
```

### 映射类型

一个常见的需求是取一个现有的类型, 并将他的所有属性转换为可选值.
假设我们有 `Person` 类型:

```ts
interface Person {
    name: string;
    age: number;
    location: string;
}
```

它的部分类型 (partial) 的版本会是这样:

```ts
interface PartialPerson {
    name?: string;
    age?: number;
    location?: string;
}
```

有了映射类型, `PartialPerson` 就可以被写作对于 `Person` 类型的一般化转换:

```ts
type Partial<T> = {
    [P in keyof T]?: T[P];
};

type PartialPerson = Partial<Person>;
```

映射类型是获取字面量类型的并集, 再通过计算新对象的属性集合产生的.
它们和 [Python 中的列表解析](https://docs.python.org/2/tutorial/datastructures.html#nested-list-comprehensions) 相似, 但不是在列表中创建新的元素, 而是在类型中创建新的属性.

除了 `Partial` 之外, 映射类型可以表达很多有用的类型转换:

```ts
// 保持类型一致, 但使每一个属性变为只读
type Readonly<T> = {
    readonly [P in keyof T]: T[P];
};

// 相同的属性名称, 但使值为 Promise 而不是具体的值
type Deferred<T> = {
    [P in keyof T]: Promise<T[P]>;
};

// 为 T 的属性添加代理
type Proxify<T> = {
    [P in keyof T]: { get(): T[P]; set(v: T[P]): void }
};
```

### `Partial`, `Readonly`, `Record` 以及 `Pick`

`Partial` 与 `Readonly`, 就像之前提到的, 是非常有用的结构.
你可以使用它们来描述一些常见的 JS 实践, 比如:

```ts
function assign<T>(obj: T, props: Partial<T>): void;
function freeze<T>(obj: T): Readonly<T>;
```

正因为如此, 它们现在默认被包含在了标准库中.

我们还引入了另外两种工具类型: `Record` 和 `Pick`.

```ts
// 从 T 挑选一些属性 K
declare function pick<T, K extends keyof T>(obj: T, ...keys: K[]): Pick<T, K>;

const nameAndAgeOnly = pick(person, "name", "age");  // { name: string, age: number }
```

```ts
// 对所有 T 类型的属性 K, 将它转换为 U
function mapObject<K extends string, T, U>(obj: Record<K, T>, f: (x: T) => U): Record<K, U>;

const names = { foo: "hello", bar: "world", baz: "bye" };
const lengths = mapObject(names, s => s.length);  // { foo: number, bar: number, baz: number }
```

### 对象的展开与剩余运算符

TypeScript 2.1 带来了对 [ES2017 展开与剩余运算符](https://github.com/sebmarkbage/ecmascript-rest-spread)的支持.

和数组的展开类似, 展开一个对象可以很方便地获得它的浅拷贝:

```ts
let copy = { ...original };
```

相似的, 你可以合并多个不同的对象.
在下面的例子中, `merged` 会有来自 `foo`, `bar` 和 `baz` 的属性.

```ts
let merged = { ...foo, ...bar, ...baz };
```

你也可以覆盖已有的属性和添加新的属性:

```ts
let obj = { x: 1, y: "string" };
var newObj = {...obj, z: 3, y: 4}; // { x: number, y: number, z: number }
```

指定展开操作的顺序决定了那些属性的值会留在创建的对象里;
在靠后的展开中出现的属性会 "战胜" 之前创建的属性.

对象的剩余操作和对象的展开是对应的, 这样一来我们可以导出解构一个元素时被漏掉的其他属性.

```ts
let obj = { x: 1, y: 1, z: 1 };
let { z, ...obj1 } = obj;
obj1; // {x: number, y: number};
```

### 异步函数的向下编译

这一特性在 TypeScript 2.1 前就已经被支持, 但仅仅是当编译到 ES6/ES2015 的时候.
TypeScript 2.1 带来了编译到 ES3 和 ES5 运行时的能力, 意味着你可以自由地运用这项优势到任何你在使用的环境.

> 注意: 首先, 我们需要确保我们的运行时有和 ECMAScript 兼容的全局 `Promise`.
> 这可能需要使用一个 `Promise` 的[实现](https://github.com/stefanpenner/es6-promise), 或者依赖目标运行时中的实现.
> 我们还需要通过设置 `lib` 选项为像 `"dom", "es2015"` 或者 `"dom", "es2015.promise", "es5"` 这样的值来确保 TypeScript 知道 `Promise` 存在.

##### 例子

##### tsconfig.json

```json
{
    "compilerOptions": {
        "lib": ["dom", "es2015.promise", "es5"]
    }
}
```

##### dramaticWelcome.ts

```ts
function delay(milliseconds: number) {
    return new Promise<void>(resolve => {
        setTimeout(resolve, milliseconds);
    });
}

async function dramaticWelcome() {
    console.log("你好");

    for (let i = 0; i < 3; i++) {
        await delay(500);
        console.log(".");
    }

    console.log("世界!");
}

dramaticWelcome();
```

编译和运行, 在 ES3/ES5 引擎中应该也会有正确的行为.

### 支持外部工具库 (`tslib`)

TypeScript 会注入一些工具函数, 比如用于继承的 `__extends`, 用于对象字面量与 JSX 元素中展开运算符的 `__assign`, 以及用于异步函数的 `__awaiter`.

过去我们有两个选择:

1. 在*所有*需要的文件中注入这些工具函数, 或者
2. 使用 `--noEmitHelpers` 完全不输出工具函数.

这两个选项很难满足已有的需求;
在每一个文件中加入这些工具函数对于关心包大小的客户来说是一个痛点.
而不包含工具函数又意味着客户需要维护自己的工具库.

TypeScript 2.1 允许在你的项目中将这些文件作为单独的模块引用, 而编译器则会在需要的时候导入它们.

首先, 安装 [`tslib`](https://github.com/Microsoft/tslib) 工具库:

```sh
npm install tslib
```

接下来, 使用 `--importHelpers` 选项编译你的文件:

```sh
tsc --module commonjs --importHelpers a.ts
```

所以使用以下作为输入, 输出的 `.js` 文件就会包含对 `tslib` 的引入, 并且使用其中的 `___assign` 工具函数而不是将它输出在文件中.

```ts
export const o = { a: 1, name: "o" };
export const copy = { ...o };
```

```js
"use strict";
var tslib_1 = require("tslib");
exports.o = { a: 1, name: "o" };
exports.copy = tslib_1.__assign({}, exports.o);
```

### 未添加类型的导入

TypeScript 过去对于如何导入模块有一些过于严格.
这样的本意是避免拼写错误, 并且帮助用户正确地使用模块.

然而, 很多时候, 你可能仅仅是想导入一个没有它自己的 `.d.ts` 文件的现有模块.
之前这是会导致错误.
从 TypeScript 2.1 开始, 则会容易很多.

使用 TypeScript 2.1, 你可以导入一个 JavaScript 模块而无需类型声明.
类型声明 (比如 `declare module "foo" { ... }` 或者 `node_modules/@types/foo`) 如果存在的话仍具有更高的优先级.

对没有声明文件的模块的导入, 在 `--noImplicitAny` 时仍会被标记为错误.

##### 例子

```ts
// 如果 `node_modules/asdf/index.js` 存在, 或 `node_modules/asdf/package.json` 定义了合法的 "main" 入口即可
import { x } from "asdf";
```

### 对 `--target ES2016`, `--target ES2017` 及 `--target ESNext` 的支持

TypeScript 2.1 支持了三个新的目标版本值 `--target ES2016`, `--target ES2017` 及 `--target ESNext`.

使用目标版本 `--target ES2016` 会告诉编译器不要对 ES2016 的特性进行转换, 比如 `**` 运算符.

相似的, `--target ES2017` 会告诉编译器不要转换 ES2017 的特性, 比如 `async`/`await`.

`--target ESNext` 则对应最新的 [ES 提案特性](https://github.com/tc39/proposals)的支持.

### 改进的 `any` 推断

之前, 如果 TypeScript 不能弄明白一个变量的类型, 它会选择 `any` 类型.

```ts
let x;      // 隐式的 'any'
let y = []; // 隐式的 'any[]'

let z: any; // 显式的 'any'.
```

在 TypeScript 2.1 中, 不同于简单地选择 `any`, TypeScript 会根据之后的赋值推断类型.

这仅会在 `--noImplicitAny` 时开启.

##### 例子

```ts
let x;

// 你仍可以将任何值赋给 'x'.
x = () => 42;

// 在上一次赋值后, TypeScript 2.1 知道 'x' 的类型为 '() => number'.
let y = x();

// 得益于此, 它现在会告诉你你不能将一个数字和函数相加!
console.log(x + y);
//          ~~~~~
// 错误! 运算符 '+' 不能被使用在类型 '() => number' 和 'number' 上.

// TypeScript 仍允许你将任何值赋给 'x'
x = "Hello world!";

// 但现在它也会知道 'x' 是 'string'!
x.toLowerCase();
```

同样的追踪现在对于空数组也会生效.

一个没有类型标注, 初始值为 `[]` 的变量声明被认为是一个隐式的 `any[]` 变量.
不过, 接下来的 `x.push(value)`, `x.unshift(value)` 或者 `x[n] = value` 操作将依据添加的元素去*演进*变量的类型.

``` ts
function f1() {
    let x = [];
    x.push(5);
    x[1] = "hello";
    x.unshift(true);
    return x;  // (string | number | boolean)[]
}

function f2() {
    let x = null;
    if (cond()) {
        x = [];
        while (cond()) {
            x.push("hello");
        }
    }
    return x;  // string[] | null
}
```

### 隐式 any 错误

这个特性的一大好处就是, 使用 `--noImplicitAny` 时你会看到的隐式 `any` 错误会比之前少*非常多*.
隐式 `any` 错误仅仅会在编译器不通过类型声明就无法知道变量类型时被报告.

##### 例子

``` ts
function f3() {
    let x = [];  // 错误: 变量 'x' 隐式地有类型 'any[]' 在一些位置的类型无法被确定.
    x.push(5);
    function g() {
        x;    // 错误: 变量 'x' 隐式地有类型 'any[]'.
    }
}
```

### 对字面量类型更好的推断

字符串, 数字和布尔值字面量类型 (例如 `"abc"`, `1`, 和 `true`) 在之前仅会在有显式的类型标注时被使用.
从 TypeScript 2.1 开始, 对于 `const` 变量和 `readonly` 属性, 字面量类型会始终作为推断的结果.

对于没有类型标注的 `const` 变量和 `readonly` 属性, 推断的类型为字面量初始值的类型.
对于有初始值, 没有类型标注的 `let` 变量, `var` 变量, 参数, 或者非 `readonly` 的属性, 推断的类型为拓宽的字面量初始值的类型.
这里拓宽的类型对于字符串字面量来说是 `string`, 对于数字字面量是 `number`, 对于 `true` 或 `false` 来说是 `boolean`, 对于枚举字面量类型则是对应的枚举类型.

##### 例子

```ts
const c1 = 1;  // 类型 1
const c2 = c1;  // 类型 1
const c3 = "abc";  // 类型 "abc"
const c4 = true;  // 类型 true
const c5 = cond ? 1 : "abc";  // 类型 1 | "abc"

let v1 = 1;  // 类型 number
let v2 = c2;  // 类型 number
let v3 = c3;  // 类型 string
let v4 = c4;  // 类型 boolean
let v5 = c5;  // 类型 number | string
```

字面量类型的拓宽可以通过显式的类型标注来控制.
具体来说, 当一个有字面量类型的表达式是通过常量位置而不是类型标注被推断时, 这个 `const` 变量被推断的是待拓宽的字面量类型.
但在 `const` 位置有显式的类型标注时, `const` 变量获得的是非待拓宽的字面量类型.

##### 例子

```ts
const c1 = "hello";  // 待拓宽类型 "hello"
let v1 = c1;  // 类型 string

const c2: "hello" = "hello";  // 类型 "hello"
let v2 = c2;  // 类型 "hello"
```

### 使用 super 的返回值作为 'this'

在 ES2015 中, 返回对象的构造函数会隐式地替换所有 `super()` 调用者的 `this` 的值.
这样一来, 捕获 `super()` 任何潜在的返回值并使用 `this` 替代则是必要的.
这一项改变使得我们可以配合[自定义元素](https://w3c.github.io/webcomponents/spec/custom/#htmlelement-constructor), 而它正是利用了这一特性来初始化浏览器分配, 却是由用户编写了构造函数的元素.

##### Example

```ts
class Base {
    x: number;
    constructor() {
        // 返回一个不同于 `this` 的新对象
        return {
            x: 1,
        };
    }
}

class Derived extends Base {
    constructor() {
        super();
        this.x = 2;
    }
}
```

生成:

```js
var Derived = (function (_super) {
    __extends(Derived, _super);
    function Derived() {
        var _this = _super.call(this) || this;
        _this.x = 2;
        return _this;
    }
    return Derived;
}(Base));
```

> 这一改变会引起对像 `Error`, `Array`, `Map` 等等的内建类的扩展行为带来不兼容的变化. 请参照[扩展内建类型不兼容变化文档](https://github.com/Microsoft/TypeScript-wiki/blob/master/Breaking-Changes.d#extending-built-ins-like-error-array-and-map-may-no-longer-work)了解详情.

### 配置继承

一个项目通常会有多个输出目标, 比如 `ES5` 和 `ES2015`, 编译和生产或 `CommonJS` 和 `System`;
在这些成对的目标中, 只有少数配置选项会改变, 而维护多个 `tsconfig.json` 文件可以会比较麻烦.

TypeScript 2.1 支持通过 `extends` 来继承配置, 在这儿:

- `extends` 是 `tsconfig.json` 中一个新的顶级属性 (同级的还有 `compilerOptions`, `files`, `include` 和 `exclude`).
- `extends` 的值必须为一个包含了到另一个被继承的配置文件的路径的字符串.
- 基文件的配置会先被加载, 然后被继承它的文件内的配置覆盖.
- 配置文件不允许出现循环.
- 继承文件中的 `files`, `include` 和 `exclude` 会*覆盖*被继承的配置文件中对应的值.
- 所有配置文件中出现的相对路径会相对这些路径所配置文件的路径来解析.

##### 例子

`configs/base.json`:

```json
{
  "compilerOptions": {
    "noImplicitAny": true,
    "strictNullChecks": true
  }
}
```

`tsconfig.json`:

```json
{
  "extends": "./configs/base",
  "files": [
    "main.ts",
    "supplemental.ts"
  ]
}
```

`tsconfig.nostrictnull.json`:

```json
{
  "extends": "./tsconfig",
  "compilerOptions": {
    "strictNullChecks": false
  }
}
```

### 新 `--alwaysStrict` 选项

使用 `--alwaysStrict` 来启动编译器会使:

1. 所有代码以严格模式进行解析.
2. 在所有生成文件的顶部输出 `"use strict";` 指令.

模块会自动以严格模式进行解析.
对于非模块代码推荐使用该新选项.

## TypeScript 2.0

### 编译器理解 null 和 undefined 类型<sup>[2]</sup>

TypeScript 有两个特殊的类型, Null 和 Undefined, 他们分别对应了值 `null` 和 `undefined`. 过去这些类型没有明确的名称, 但 `null` 和 `undefined` 现在可以在任意类型检查模式下作为类型名称使用.

类型检查系统过去认为 `null` 和 `undefined` 可以赋值给任何东西. 或者说, `null` 和 `undefined` 是任何类型的合法值, 并且之前无法将他们排除 (由此也无法检测相关的错误使用).

#### `--strictNullChecks`

`--strictNullChecks` 选项会启用新的严格空值检查模式.

在严格空值检查模式下, 值 `null` 和 `undefined` 不再属与所有类型并且只能赋值给它们自己对应的类型和 `any` (一个例外是 `undefined` 也可以被复制给 `void`). 所以, 虽然在普通类型检查模式 `T` 和 `T | undefined` 意义相同 (因为 `undefined` 被认为是任何 `T` 的子类型), 在严格类型检查模式下它们是不同的, 并且只有 `T | undefined` 允许 `undefined` 作为值. `T` 和 `T | null` 的关系也是如此.

##### 例子

```ts
// 使用 --strictNullChecks 选项编译
let x: number;
let y: number | undefined;
let z: number | null | undefined;
x = 1;  // 正确
y = 1;  // 正确
z = 1;  // 正确
x = undefined;  // 错误
y = undefined;  // 正确
z = undefined;  // 正确
x = null;  // 错误
y = null;  // 错误
z = null;  // 正确
x = y;  // 错误
x = z;  // 错误
y = x;  // 正确
y = z;  // 错误
z = x;  // 正确
z = y;  // 正确
```

#### 使用前赋值检查

在严格空值检查模式下, 编译器要求每个类型中不包含 `undefined` 的本地变量的引用在它之前的代码路径里被赋值.

##### 例子

```ts
// 使用 --strictNullChecks 选项编译
let x: number;
let y: number | null;
let z: number | undefined;
x;  // 错误, 引用使用前没有被赋值
y;  // 错误, 引用使用前没有被赋值
z;  // 正确
x = 1;
y = null;
x;  // 正确
y;  // 正确
```

#### 可选参数和属性

可选参数和属性类型会自动包含 `undefined`, 即便它们的类型标注没有明确包含 `undefined`. 举个例子, 下面的两个类型是等价的:

```ts
// 使用 --strictNullChecks 选项编译
type T1 = (x?: number) => string;              // x 的类型为 number | undefined
type T2 = (x?: number | undefined) => string;  // x 的类型为 number | undefined
```

#### 非 null 和非 undefined 类型收窄

如果一个对象的类型包含了 `null` 或者 `undefined`, 访问它的属性或者调用它的方法会产生编译时错误. 然而, 类型收窄已经支持了非 null 和非 undefined 检查.

##### 例子

```ts
// 使用 --strictNullChecks 选项编译
declare function f(x: number): string;
let x: number | null | undefined;
if (x) {
    f(x);  // 正确, x 的类型在这里是 number
}
else {
    f(x);  // 错误, x 的类型在这里是 number?
}
let a = x != null ? f(x) : "";  // a 的类型为 string
let b = x && f(x);  // b 的类型为 string | 0 | null | undefined
```

非 null 和非 undefined 类型收窄可以使用 `==`, `!=`, `===` 或者 `!==` 运算符与 `null` 或者 `undefined` 进行比较, 比如 `x != null` 或者 `x === undefined`. 对目标变量类型的效果能准确反映 JavaScript 的语义 (比如双等号运算符两个值都会检查, 而三等号只会检查指定的值).

#### 类型收窄中带点的名称

类型收窄过去只支持对本地变量和参数的检查. 现在类型收窄支持检查包含了带一级或多级属性访问的变量或参数的 "带点的名称".

##### 例子

```ts
interface Options {
    location?: {
        x?: number;
        y?: number;
    };
}

function foo(options?: Options) {
    if (options && options.location && options.location.x) {
        const x = options.location.x;  // x 的类型为 number
    }
}
```

对于带点名称的类型收窄也可以和用户自定义的类型收窄函数及 `typeof` 和 `instanceof` 运算符一起使用, 并且不依赖 `--strictNullChecks` 编译器选项.

带点名称的类型收窄如果跟着对其任意部分的赋值, 会使收窄无效. 比如说, 对于 `x.y.z` 的类型收窄如果后面跟着对 `x`, `x.y` 或者 `x.y.z` 的赋值都会使其无效.

#### 表达式运算符

表达式运算符允许操作数的类型包含 `null` 和/或 `undefined`, 但会总是产生类型为非 null 和非 undefined 的值.

```ts
// 使用 --strictNullChecks 选项编译
function sum(a: number | null, b: number | null) {
    return a + b;  // 产生类型为 number 的值
}
```

`&&` 运算符会根据左边操作数的类型将 `null` 和/或 `undefined` 添加到右边被操作数的类型上, 而 `||` 运算符会在结果的联合类型中同时移除左边被操作数类型中的 `null` 和 `undefined`.

```ts
// 使用 --strictNullChecks 选项编译
interface Entity {
    name: string;
}
let x: Entity | null;
let s = x && x.name;  // s 的类型为 string | null
let y = x || { name: "test" };  // y 的类型为 Entity
```

#### 类型拓宽

`null` 和 `undefined` 类型在严格空值检查模式中不会被拓宽为 `any`.

```ts
let z = null;  // z 的类型为 null
```

在普通的类型检查模式中, 会因为拓宽将 `z` 的类型推断为 `any`, 但在严格空值检查模式中, `z` 推断得出的类型是 `null` (也正因为如此, 在没有类型标注的情况下, `null` 是 `z` 唯一可能的值).

#### 非空断言运算符

在类型检查器无法得出与实际相符的结论的上下文中, 可以使用新的 `!` 后缀表达式运算符来声明它的操作数是非 null 和非 undefined 的. 特别的, 运算 `x!` 会得出 `x` 排除 `null` 和 `undefined` 后的类型的值. 与 `<T>x` 和 `x as T` 这种形式的类型断言相似, `!` 非空断言运算符在输出的 JavaScript 代码中会被直接移除.

```ts
// 使用 --strictNullChecks 选项编译
function validateEntity(e?: Entity) {
    // 当 e 是 null 或非法 entity 时抛出异常
}

function processEntity(e?: Entity) {
    validateEntity(e);
    let s = e!.name;  // 声明 e 非 null 并且访问 name
}
```

#### 兼容性

这些新的特性在设计的时候考虑了严格空值检查模式和常规类型检查模式下的使用. 比如 `null` 和 `undefined` 类型在常规类型检查模式下会从联合类型中自动清除 (因为它们是其他任何类型的子类型), 而 `!` 非空断言运算符虽然允许在常规类型检查模式中使用, 但不会有效果. 于是, 更新后支持可为 null 或者 undefined 类型的声明文件为了向后兼容依然可以在常规类型检查模式下使用.

实际使用时, 严格的空值检查模式需要所有被编译的文件包含是否可为 null 或 undefined 的信息.

### 基于控制流的类型分析

TypeScript 2.0 实现了对于本地变量和参数基于控制流的类型分析. 过去对类型收窄进行的分析仅限于 `if` 语句和 `?:` 条件表达式, 并没有包含赋值和控制流结构带来的影响, 比如 `return` 和 `break` 语句. 在 TypeScript 2.0 中, 类型检查器会分析语句和表达式中所有可能的控制流, 以尽可能得出包含联合类型的本地变量及参数在指定位置最准确的类型 (收窄的类型).

##### 例子

```ts
function foo(x: string | number | boolean) {
    if (typeof x === "string") {
        x; // x 的类型在这里是 string
        x = 1;
        x; // x 的类型在这里是 number
    }
    x; // x 的类型在这里是 number | boolean
}

function bar(x: string | number) {
    if (typeof x === "number") {
        return;
    }
    x; // x 的类型在这里是 string
}
```

基于控制流的类型分析在 `--strictNullChecks` 模式下非常重要, 因为可空的类型是使用联合类型表示的:

```ts
function test(x: string | null) {
    if (x === null) {
        return;
    }
    x; // x 在这之后的类型为 string
}
```

此外, 在 `--strictNullChecks` 模式, 基于控制流的类型分析包含了对类型不允许值 `undefined` 的本地变量的*明确赋值分析*.

```ts
function mumble(check: boolean) {
    let x: number; // 类型不允许 undefined
    x; // 错误, x 是 undefined
    if (check) {
        x = 1;
        x; // 正确
    }
    x; // 错误, x 可能是 undefined
    x = 2;
    x; // 正确
}
```

### 带标记的联合类型

TypeScript 2.0 实现了对带标记的 (或被区别的) 联合类型. 特别的, TS 编译器现在支持通过对可识别的属性进行判断来收窄联合类型, 并且支持 `switch` 语句.

##### 例子

```ts
interface Square {
    kind: "square";
    size: number;
}

interface Rectangle {
    kind: "rectangle";
    width: number;
    height: number;
}

interface Circle {
    kind: "circle";
    radius: number;
}

type Shape = Square | Rectangle | Circle;

function area(s: Shape) {
    // 在下面的语句中, s 的类型在每一个分支中都被收窄了
    // 根据可识别属性的值, 允许变量的其他属性在没有类型断言的情况下被访问
    switch (s.kind) {
        case "square": return s.size * s.size;
        case "rectangle": return s.width * s.height;
        case "circle": return Math.PI * s.radius * s.radius;
    }
}

function test1(s: Shape) {
    if (s.kind === "square") {
        s;  // Square
    }
    else {
        s;  // Rectangle | Circle
    }
}

function test2(s: Shape) {
    if (s.kind === "square" || s.kind === "rectangle") {
        return;
    }
    s;  // Circle
}
```

*可识别属性的类型收窄*可以是如下的表达式 `x.p == v`, `x.p === v`, `x.p != v`, 或 `x.p !== v`, 其中 `p` 和 `v` 分别是一个属性和一个为字符串字面量类型或字符串字面量类型的联合类型的表达式.
可识别属性的类型收窄会将 `x` 的类型收窄到包含的可识别属性 `p` 为 `v` 一个可能的值的 `x` 的部分类型.

注意我们现在仅支持字符串字面量类型的可识别属性.
我们打算在以后增加布尔值和数字的字面类型.

### `never` 类型

TypeScript 2.0 引入了新的原始类型 `never`.
`never` 类型代表从来不会出现的值的类型.
特别的, `never` 可以是永远不返回的函数的返回值类型, 也可以是变量在类型收窄中不可能为真的类型.

`never` 类型有以下特征:

* `never` 是任何类型的子类型, 并且可以赋值给任何类型.
* 没有类型是 `never` 的子类型或者可以复制给 `never` (除了 `never` 本身).
* 在一个没有返回值标注的函数表达式或箭头函数中, 如果函数没有 `return` 语句, 或者仅有表达式类型为 `never` 的 `return` 语句, 并且函数的终止点无法被执行到 (按照控制流分析), 则推导出的函数返回值类型是 `never`.
* 在一个明确指定了 `never` 返回值类型的函数中, 所有 `return` 语句 (如果有) 表达式的值必须为 `never` 类型, 且函数不应能执行到终止点.

由于 `never` 是所有类型的子类型, 在联合类型中它始终被省略, 并且只要函数有其他返回的类型, 推导出的函数返回值类型中就会忽略它.

一些返回 `never` 的函数的例子:

```ts
// 返回 never 的函数必须有无法被执行到的终止点
function error(message: string): never {
    throw new Error(message);
}

// 推断的返回值是 never
function fail() {
    return error("一些东西失败了");
}

// 返回 never 的函数必须有无法被执行到的终止点
function infiniteLoop(): never {
    while (true) {
    }
}
```

一些使用返回 `never` 的函数的例子:

```ts
// 推断的返回值类型为 number
function move1(direction: "up" | "down") {
    switch (direction) {
        case "up":
            return 1;
        case "down":
            return -1;
    }
    return error("永远不应该到这里");
}

// 推断的返回值类型为 number
function move2(direction: "up" | "down") {
    return direction === "up" ? 1 :
        direction === "down" ? -1 :
        error("永远不应该到这里");
}

// 推断的返回值类型为 T
function check<T>(x: T | undefined) {
    return x || error("未定义的值");
}
```

因为 `never` 可以赋值给任何类型, 返回 `never` 的函数可以在回调需要返回一个具体类型的时候被使用:

```ts
function test(cb: () => string) {
    let s = cb();
    return s;
}

test(() => "hello");
test(() => fail());
test(() => { throw new Error(); })
```

### 只读属性和索引签名

现在结合 `readonly` 修饰符声明的属性或者索引签名会被认为是只读的.

只读属性可以有初始化语句, 并且可以在当前类声明的构造函数中被赋值, 但对于只读属性其他形式的赋值是不被允许的.

另外, 在一些情况下, 实体是*隐式*只读的:

* 一个只有 `get` 访问符没有 `set` 访问符声明的属性被认为是只读的.
* 在枚举对象的类型中, 枚举成员被认为是只读属性.
* 在模块对象的类型中, 导出的 `const` 变量被认为是只读属性.
* 在 `import` 语句中声明的实体被认为是只读的.
* 通过 ES2015 命名空间导入来访问的实体被认为是只读的 (比如当 `foo` 为 `import * as foo from "foo"` 声明时, `foo.x` 是只读的).

##### 例子

```ts
interface Point {
    readonly x: number;
    readonly y: number;
}

var p1: Point = { x: 10, y: 20 };
p1.x = 5;  // 错误, p1.x 是只读的

var p2 = { x: 1, y: 1 };
var p3: Point = p2;  // 正确, p2 的只读别名
p3.x = 5;  // 错误, p3.x 是只读的
p2.x = 5;  // 正确, 但由于是别名也会改变 p3.x
```

```ts
class Foo {
    readonly a = 1;
    readonly b: string;
    constructor() {
        this.b = "hello";  // 在构造函数中允许赋值
    }
}
```

```ts
let a: Array<number> = [0, 1, 2, 3, 4];
let b: ReadonlyArray<number> = a;
b[5] = 5;      // 错误, 元素是只读的
b.push(5);     // 错误, 没有 push 方法 (因为它会改变数组)
b.length = 3;  // 错误, length 是只读的
a = b;         // 错误, 缺少会改变数组值的方法
```

### 指定函数的 `this` 类型

在指定类和接口中 `this` 的类型之后, 函数和方法现在可以声明它们期望的 `this` 类型了.

函数中 `this` 的类型默认为 `any`.
从 TypeScript 2.0 开始, 你可以添加一个明确地 `this` 参数.
`this` 参数是位于函数参数列表开头的假参数.

```ts
function f(this: void) {
    // 确保 `this` 在这个单独的函数中不可用
}
```

#### 回调函数中的 `this` 参数

库也可以使用 `this` 参数来声明回调会如何被调用.

##### 例子

```ts
interface UIElement {
    addClickListener(onclick: (this: void, e: Event) => void): void;
}
```

`this: void` 说明 `addClickListener` 期望 `onclick` 是一个不要求 `this` 类型的函数.

现在如果你标注 `this` 的调用代码:

```ts
class Handler {
    info: string;
    onClickBad(this: Handler, e: Event) {
        // 啊哦, 这里使用了 this. 把它用作回调函数可能会在运行时崩掉
        this.info = e.message;
    };
}
let h = new Handler();
uiElement.addClickListener(h.onClickBad); // 错误!
```

#### `--noImplicitThis`

在 TypeScript 2.0 中也加入了一个新的选项来检查函数中没有明确标注类型的 `this` 的使用.

### `tsconfig.json` 对 glob 的支持

支持 glob 啦!! 对 glob 的支持一直是[呼声最高的特性之一](https://github.com/Microsoft/TypeScript/issues/1927).

类似 glob 的文件匹配模板现在被 `"include"` 和 `"exclude"` 两个属性支持.

##### 例子

```json
{
    "compilerOptions": {
        "module": "commonjs",
        "noImplicitAny": true,
        "removeComments": true,
        "preserveConstEnums": true,
        "outFile": "../../built/local/tsc.js",
        "sourceMap": true
    },
    "include": [
        "src/**/*"
    ],
    "exclude": [
        "node_modules",
        "**/*.spec.ts"
    ]
}
```

支持的 glob 通配符有:

* `*` 匹配零个或多个字符 (不包括目录分隔符)
* `?` 匹配任意一个字符 (不包括目录分隔符)
* `**/` 递归匹配子目录

如果 glob 模板的一个片段只包含 `*` 或 `.*`, 那么只有扩展名被支持的文件会被包含 (比如默认有 `.ts`, `.tsx` 和 `.d.ts`, 如果 `allowJs` 被启用的话还有 `.js` 和 `.jsx`).

如果 `"files"` 和 `"include"` 都没有指定, 编译器会默认包含当前目录及其子目录中除开由 `"exclude"` 属性排除的以外所有 TypeScript (`.ts`, `.d.ts` 和 `.tsx`) 文件. 如果 `allowJs` 被开启, JS 文件 (`.js` 和 `.jsx`) 也会被包含.

如果指定了 `"files"` 或 `"include"` 属性, 编译器便会包含两个属性指定文件的并集.
除非明确地通过 `"files"` 属性指定 (即便指定了 `"exclude"` 属性), 在使用 `"outDir"` 编译器选项指定目录中的文件总是会被排除.

使用 `"include"` 包含的文件可以使用 `"exclude"` 属性排除.
然而, 由 `"files"` 属性明确包含的文件总是会被包含, 不受 `"exclude"` 影响.
如果没有指定, `"exclude"` 属性默认会排除 `node_modules`, `bower_components` 以及 `jspm_packages` 目录.

### 模块解析增强: 基准 URL, 路径映射, 多个根目录及追踪

TypeScript 2.0 提供了一系列模块解析配置来*告知*编译器从哪里找到给定模块的声明.

见[模块解析](http://www.typescriptlang.org/docs/handbook/module-resolution.html)文档了解更多内容.

#### 基准 URL

对于使用 AMD 模块加载器将模块在运行时 "部署" 到单个文件夹的应用来说, 使用 `baseUrl` 是一个通用的做法.
所有没有相对名称的模块引用都被假设为相对 `baseUrl`.

##### 例子

```json
{
  "compilerOptions": {
    "baseUrl": "./modules"
  }
}
```

现在对 `"moduleA"` 的导入会查找 `./modules/moduleA`

```ts
import A from "moduleA";
```

#### 路径映射

有时模块没有直接在 *baseUrl* 中.
加载器使用映射配置将模块名称与文件在运行时对应起来, 见 [RequireJS 文档](http://requirejs.org/docs/api.html#config-paths)和 [SystemJS 文档](https://github.com/systemjs/systemjs/blob/master/docs/overview.md#map-config).

TypeScript 编译器支持在 `tsconfig.json` 里使用 `"path"` 属性来声明这样的映射.

##### 例子

举例来说, 导入模块 `"jquery"` 会编译为运行时的 `"node_modules/jquery/dist/jquery.slim.min.js"`.

```json
{
  "compilerOptions": {
    "paths": {
      "jquery": ["jquery/dist/jquery.slim.min"]
    }
  }
}
```

通过 `"path"` 还可以实现更多包括多级回落路径在内的高级映射.
考虑一个部分模块在一个位置, 其他的在另一个位置的项目配置.

#### 使用 `rootDirs` 配置虚拟路径

你可以使用 `rootDirs` 告知编译器组成这个 "虚拟" 路径的多个*根路径*;
这样一来, 编译器会将这些 "虚拟" 目录中的相对模块引入*当做*它们是被合并到同一个目录下的来解析.

##### 例子

假定项目结构如下:

```tree
 src
 └── views
     └── view1.ts (imports './template1')
     └── view2.ts

 generated
 └── templates
         └── views
             └── template1.ts (imports './view2')
```

构建步骤会将 `/src/views` 和 `/generated/templates/views` 中的文件在输出中复制到同一目录.
在运行时, 一个视图会期望它的模板在它旁边, 这样就应该使用相对的名称 `"./template"` 来导入它.

`"rootDirs"` 指定了将在运行时合并的*多个根目录*的列表.
所以对于我们的例子, `tsconfig.json` 文件应该像这样:

```json
{
  "compilerOptions": {
    "rootDirs": [
      "src/views",
      "generated/templates/views"
    ]
  }
}
```

#### 追踪模块解析

`--traceResolution` 提供了一个方便的途径帮助理解模块是如何被编译器解析的.

```shell
tsc --traceResolution
```

### 简易外围模块声明

现在如果你不想在使用一个新的模块前花时间写声明信息, 你可以直接使用一个简易声明迅速开始.

##### declarations.d.ts

```ts
declare module "hot-new-module";
```

所有从简易模块中导入的项都为 `any` 类型.

```ts
import x, {y} from "hot-new-module";
x(y);
```

### 模块名中的通配符

从模块加载器扩展 (比如 [AMD](https://github.com/amdjs/amdjs-api/blob/master/LoaderPlugins.md) 或者 [SystemJS](https://github.com/systemjs/systemjs/blob/master/docs/creating-plugins.md)) 中导入非代码资源过去并不容易;
在这之前每一个资源都必须定义对应的外围模块声明.

TypeScript 2.0 支持使用通配符 (`*`) 来声明一组模块名称;
这样, 声明一次就可以对应一组扩展, 而不是单个资源.

##### 例子

```ts
declare module "*!text" {
    const content: string;
    export default content;
}

// 有的使用另一种方式
declare module "json!*" {
    const value: any;
    export default value;
}
```

现在你就可以导入匹配 `"*!text"` 或者 `"json!*"` 的东西了.

```ts
import fileContent from "./xyz.txt!text";
import data from "json!http://example.com/data.json";
console.log(data, fileContent);
```

通配符模块名在从无类型的代码迁移的过程中会更加有用.
结合简易模块声明, 一组模块可以轻松地被声明为 `any`.

##### 例子

```ts
declare module "myLibrary/*";
```

所有对 `myLibrary` 下的模块的导入会被编译器认为是 `any` 类型;
这样, 对于这些模块的外形或类型的检查都会被关闭.

```ts
import { readFile } from "myLibrary/fileSystem/readFile";

readFile(); // readFile 的类型是 any
```

### 支持 UMD 模块定义

一些库按设计可以在多个模块加载器中使用, 或者不使用模块加载 (全局变量).
这种方式被叫做 [UMD](https://github.com/umdjs/umd) 或者[同构](http://isomorphic.net)模块.
这些库既可以使用模块导入, 也可以通过全局变量访问.

比如:

##### math-lib.d.ts

```ts
export const isPrime(x: number): boolean;
export as namespace mathLib;
```

这个库现在就可以在模块中作为导入项被使用:

```ts
import { isPrime } from "math-lib";
isPrime(2);
mathLib.isPrime(2); // 错误: 在模块中不能使用全局定义
```

它也可以被用作全局变量, 但是仅限于脚本中.
(脚本是指不包含导入项或者导出项的文件.)

```ts
mathLib.isPrime(2);
```

### 可选的类属性

可选的类属性和方法现在可以在类中被声明了, 与之前已经在接口中允许的相似.

##### 例子

```ts
class Bar {
    a: number;
    b?: number;
    f() {
        return 1;
    }
    g?(): number;  // 可选方法的函数体可以被省略
    h?() {
        return 2;
    }
}
```

当在 `--strictNullChecks` 模式下编译时, 可选属性和方法会自动在其类型中包含 `undefined`. 如此, 上面的 `b` 属性类型为 `number | undefined`, `g` 方法类型为 `(() => number) | undefined`.
类型收窄可以被用来排除这些类型中的 `undefined` 部分:

```ts
function test(x: Bar) {
    x.a;  // number
    x.b;  // number | undefined
    x.f;  // () => number
    x.g;  // (() => number) | undefined
    let f1 = x.f();            // number
    let g1 = x.g && x.g();     // number | undefined
    let g2 = x.g ? x.g() : 0;  // number
}
```

### 私有和受保护的构造函数

类的构造函数可以被标记为 `private` 或 `protected`.
一个有私有构造函数的类不能在类定义以外被实例化, 并且不能被扩展.
一个有受保护构造函数的类不能在类定义以外被实例化, 但是可以被扩展.

##### 例子

```ts
class Singleton {
    private static instance: Singleton;

    private constructor() { }

    static getInstance() {
        if (!Singleton.instance) {
            Singleton.instance = new Singleton();
        }
        return Singleton.instance;
    }
}

let e = new Singleton(); // 错误: 'Singleton' 的构造函数是私有的.
let v = Singleton.getInstance();
```

### 抽象属性和访问器

一个抽象类可以声明抽象的属性和/或访问器.
一个子类需要声明这些抽象的属性或者被标记为抽象的.
抽象的属性不能有初始值.
抽象的访问器不能有定义.

##### 例子

```ts
abstract class Base {
    abstract name: string;
    abstract get value();
    abstract set value(v: number);
}

class Derived extends Base {
    name = "derived";
    value = 1;
}
```

### 隐式索引签名

现在如果一个对象字面量中所有已知的属性可以赋值给一个索引签名, 那么这个对象字面量类型就可以赋值给有该索引签签名的类型. 这使得将使用对象字面量初始化的变量可以作为参数传递给接受映射或字典的函数:

```ts
function httpService(path: string, headers: { [x: string]: string }) { }

const headers = {
    "Content-Type": "application/x-www-form-urlencoded"
};

httpService("", { "Content-Type": "application/x-www-form-urlencoded" });  // 正确
httpService("", headers);  // 现在可以, 过去不行
```

### 使用 `--lib` 加入内建类型声明

过去使用 ES6/2015 的内建 API 声明仅限于 `target: ES6`.
输入 `--lib`; 通过 `--lib` 你可以指定你希望在项目中包含的内建 API 声明组.
举例来说, 如果你期望运行时支持 `Map`, `Set` 和 `Promise` (比如目前较新的浏览器), 只需要加入 `--lib es2015.collection,es2015.promise`.
相似的, 你可以从你的项目中排除你不希望加入的声明, 比如在使用 `--lib es5,es6` 选项的 node 项目中排除 DOM.

这里列出了可选的 API 组:

* dom
* webworker
* es5
* es6 / es2015
* es2015.core
* es2015.collection
* es2015.iterable
* es2015.promise
* es2015.proxy
* es2015.reflect
* es2015.generator
* es2015.symbol
* es2015.symbol.wellknown
* es2016
* es2016.array.include
* es2017
* es2017.object
* es2017.sharedmemory
* scripthost

##### 例子

```bash
tsc --target es5 --lib es5,es6.promise
```

```json
"compilerOptions": {
    "lib": ["es5", "es2015.promise"]
}
```

### 使用 `--noUnusedParameters` 和 `--noUnusedLocals` 标记未使用的声明

TypeScript 2.0 提供了两个新的选项来帮助你保持代码整洁.
`--noUnusedParameters` 可以标记所有未使用的函数或方法参数为错误.
`--noUnusedLocals` 可以标记所有未使用的本地 (未导出的) 声明, 比如变量, 函数, 类, 导入项等等.
另外, 类中未使用的私有成员也会被 `--noUnusedLocals` 标记为错误.

##### 例子
```ts
import B, { readFile } from "./b";
//     ^ 错误: `B` 被声明但从未使用
readFile();


export function write(message: string, args: string[]) {
    //                                 ^^^^  错误: `arg` 被声明但从未使用
    console.log(message);
}
```

名称由 `_` 开头的参数声明不会被检查是否未使用.
比如:

```ts
function returnNull(_a) { // 正确
    return null;
}
```

### 模块名称允许 `.js` 扩展名

在 TypeScript 2.0 之前, 模块名称一直被假设是没有扩展名的;
举例来说, 对于模块导入 `import d from "./moduleA.js"`, 编译器会到 `./moduleA.js.ts` 或 `./moduleA.js.d.ts` 中查找 `"moduleA.js"` 的声明.
这让使用像 [SystemJS](https://github.com/systemjs/systemjs) 这样期望模块名是 URI 的打包/加载工具变得不方便.

对于 TypeScript 2.0, 编译器会到 `./moduleA.ts` 或 `./moduleA.d.ts` 中查找 `"moduleA.js"` 的声明.

### 支持同时使用 `target: es5` 和 `module: es6`

之前这被认为是不合法的选项组合, 现在 `target: es5` 和 `module: es6` 可以一并使用了.
这可以方便使用基于 ES2015 的冗余代码清理工具, 比如 [rollup](https://github.com/rollup/rollup).

### 函数形参和实参列表结尾处的逗号

现在允许了函数形参和实参列表结尾处的逗号.
这是一个[第三阶段的 ECMAScript 提议](https://jeffmo.github.io/es-trailing-function-commas/)对应的实现, 并且会编译为可用的 ES3/ES5/ES6.

##### 例子
```ts
function foo(
  bar: Bar,
  baz: Baz, // 形参列表可以以逗号结尾
) {
  // 实现...
}

foo(
  bar,
  baz, // 实参列表也可以
);
```

### 新的 `--skipLibCheck`

TypeScript 2.0 添加了一个新的 `--skipLibCheck` 编译器选项来跳过对声明文件 (扩展名为 `.d.ts` 的文件) 的类型检查.
当程序包含了大的声明文件时, 编译器会花掉很多时间对这些已知没有错误的声明进行类型检查, 跳过这些声明文件的类型检查能够显著缩短编译时间.

由于一个文件中的声明可能影响其他文件中的类型检查, 指定 `--skipLibCheck` 可能导致一些错误无法被检测到.
比如说, 如果一个非声明文件中的类型被声明文件用到, 可能仅在声明文件被检查时能发现错误.
不过这种情况在实际使用中并不常见.

### 支持多个声明中出现重复的标示符

这是造成重复定义错误的常见原因之一.
多个声明文件在接口中定义了同样的成员.

TypeScript 2.0 放宽了相关约束并允许不同代码块中出现重复的标示符, 只要它们的类型*等价*.

在同一个代码块中的重复定义依然是不被允许的.

##### 例子

```ts
interface Error {
    stack?: string;
}

interface Error {
    code?: string;
    path?: string;
    stack?: string;  // 正确
}
```

### 新的 `--declarationDir`

`--declarationDir` 允许将声明文件生成到和 JavaScript 文件不同的位置.


## TypeScript 1.8

### 类型参数约束

在 TypeScript 1.8 中, 类型参数的限制可以引用自同一个类型参数列表中的类型参数. 在此之前这种做法会报错. 这种特性通常被叫做 [F-Bounded Polymorphism](https://en.wikipedia.org/wiki/Bounded_quantification#F-bounded_quantification).

#### 例子

```ts
function assign<T extends U, U>(target: T, source: U): T {
    for (let id in source) {
        target[id] = source[id];
    }
    return target;
}

let x = { a: 1, b: 2, c: 3, d: 4 };
assign(x, { b: 10, d: 20 });
assign(x, { e: 0 });  // 错误
```

### 控制流错误分析

TypeScript 1.8 中引入了控制流分析来捕获开发者通常会遇到的一些错误.

详情见接下来的内容, 可以上手尝试:

![cfa](https://cloud.githubusercontent.com/assets/8052307/5210657/c5ae0f28-7585-11e4-97d8-86169ef2a160.gif)

#### 不可及的代码

一定无法在运行时被执行的语句现在会被标记上代码不可及错误. 举个例子, 在无条件限制的 `return`, `throw`, `break` 或者 `continue` 后的语句被认为是不可及的. 使用 `--allowUnreachableCode` 来禁用不可及代码的检测和报错.

##### 例子

这里是一个简单的不可及错误的例子:

```ts
function f(x) {
    if (x) {
       return true;
    }
    else {
       return false;
    }

    x = 0; // 错误: 检测到不可及的代码.
}
```

这个特性能捕获的一个更常见的错误是在 `return` 语句后添加换行:

```ts
function f() {
    return            // 换行导致自动插入的分号
    {
        x: "string"   // 错误: 检测到不可及的代码.
    }
}
```

因为 JavaScript 会自动在行末结束 `return` 语句, 下面的对象字面量变成了一个代码块.

#### 未使用的标签

未使用的标签也会被标记. 和不可及代码检查一样, 被使用的标签检查也是默认开启的. 使用 `--allowUnusedLabels` 来禁用未使用标签的报错.

##### 例子

```ts
loop: while (x > 0) {  // 错误: 未使用的标签.
    x++;
}
```

#### 隐式返回

JS 中没有返回值的代码分支会隐式地返回 `undefined`. 现在编译器可以将这种方式标记为隐式返回. 对于隐式返回的检查默认是被禁用的, 可以使用 `--noImplicitReturns` 来启用.

##### 例子

```ts
function f(x) { // 错误: 不是所有分支都返回了值.
    if (x) {
        return false;
    }

    // 隐式返回了 `undefined`
}
```

#### Case 语句贯穿

TypeScript 现在可以在 switch 语句中出现贯穿的几个非空 case 时报错.
这个检测默认是关闭的, 可以使用 `--noFallthroughCasesInSwitch` 启用.

##### 例子

```ts
switch (x % 2) {
    case 0: // 错误: switch 中出现了贯穿的 case.
        console.log("even");

    case 1:
        console.log("odd");
        break;
}
```

然而, 在下面的例子中, 由于贯穿的 case 是空的, 并不会报错:

```ts
switch (x % 3) {
    case 0:
    case 1:
        console.log("Acceptable");
        break;

    case 2:
        console.log("This is *two much*!");
        break;
}
```

### React 无状态的函数组件

TypeScript 现在支持[无状态的函数组件](https://facebook.github.io/react/docs/reusable-components.html#stateless-functions).
它是可以组合其他组件的轻量级组件.

```ts
// 使用参数解构和默认值轻松地定义 'props' 的类型
const Greeter = ({name = 'world'}) => <div>Hello, {name}!</div>;

// 参数可以被检验
let example = <Greeter name='TypeScript 1.8' />;
```

如果需要使用这一特性及简化的 props, 请确认使用的是[最新的 react.d.ts](https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/react).

### 简化的 React `props` 类型管理

在 TypeScript 1.8 配合最新的 react.d.ts (见上方) 大幅简化了 `props` 的类型声明.

具体的:

- 你不再需要显式的声明 `ref` 和 `key` 或者 `extend React.Props`
- `ref` 和 `key` 属性会在所有组件上拥有正确的类型.
- `ref` 属性在无状态函数组件上会被正确地禁用.

### 在模块中扩充全局或者模块作用域

用户现在可以为任何模块进行他们想要, 或者其他人已经对其作出的扩充.
模块扩充的形式和过去的包模块一致 (例如 `declare module "foo" { }` 这样的语法), 并且可以直接嵌在你自己的模块内, 或者在另外的顶级外部包模块中.

除此之外, TypeScript 还以 `declare global { }` 的形式提供了对于_全局_声明的扩充.
这能使模块对像 `Array` 这样的全局类型在必要的时候进行扩充.

模块扩充的名称解析规则与 `import` 和 `export` 声明中的一致.
扩充的模块声明合并方式与在同一个文件中声明是相同的.

不论是模块扩充还是全局声明扩充都不能向顶级作用域添加新的项目 - 它们只能为已经存在的声明添加 "补丁".

#### 例子

这里的 `map.ts` 可以声明它会在内部修改在 `observable.ts` 中声明的 `Observable` 类型, 添加 `map` 方法.

```ts
// observable.ts
export class Observable<T> {
    // ...
}
```

```ts
// map.ts
import { Observable } from "./observable";

// 扩充 "./observable"
declare module "./observable" {

    // 使用接口合并扩充 'Observable' 类的定义
    interface Observable<T> {
        map<U>(proj: (el: T) => U): Observable<U>;
    }

}

Observable.prototype.map = /*...*/;
```

```ts
// consumer.ts
import { Observable } from "./observable";
import "./map";

let o: Observable<number>;
o.map(x => x.toFixed());
```

相似的, 在模块中全局作用域可以使用 `declare global` 声明被增强:

#### 例子

```ts
// 确保当前文件被当做一个模块.
export {};

declare global {
    interface Array<T> {
        mapToNumbers(): number[];
    }
}

Array.prototype.mapToNumbers = function () { /* ... */ }
```

### 字符串字面量类型

接受一个特定字符串集合作为某个值的 API 并不少见.
举例来说, 考虑一个可以通过控制[动画的渐变](https://en.wikipedia.org/wiki/Inbetweening)让元素在屏幕中滑动的 UI 库:

```ts
declare class UIElement {
    animate(options: AnimationOptions): void;
}

interface AnimationOptions {
    deltaX: number;
    deltaY: number;
    easing: string; // 可以是 "ease-in", "ease-out", "ease-in-out"
}
```

然而, 这容易产生错误 - 当用户错误不小心错误拼写了一个合法的值时, 并没有任何提示:

```ts
// 没有报错
new UIElement().animate({ deltaX: 100, deltaY: 100, easing: "ease-inout" });
```

在 TypeScript 1.8 中, 我们新增了字符串字面量类型. 这些类型和字符串字面量的写法一致, 只是写在类型的位置.

用户现在可以确保类型系统会捕获这样的错误.
这里是我们使用了字符串字面量类型的新的 `AnimationOptions`:

```ts
interface AnimationOptions {
    deltaX: number;
    deltaY: number;
    easing: "ease-in" | "ease-out" | "ease-in-out";
}

// 错误: 类型 '"ease-inout"' 不能复制给类型 '"ease-in" | "ease-out" | "ease-in-out"'
new UIElement().animate({ deltaX: 100, deltaY: 100, easing: "ease-inout" });
```

### 更好的联合/交叉类型接口

TypeScript 1.8 优化了源类型和目标类型都是联合或者交叉类型的情况下的类型推导.
举例来说, 当从 `string | string[]` 推导到 `string | T` 时, 我们将类型拆解为 `string[]` 和 `T`, 这样就可以将 `string[]` 推导为 `T`.

#### 例子

```ts
type Maybe<T> = T | void;

function isDefined<T>(x: Maybe<T>): x is T {
    return x !== undefined && x !== null;
}

function isUndefined<T>(x: Maybe<T>): x is void {
    return x === undefined || x === null;
}

function getOrElse<T>(x: Maybe<T>, defaultValue: T): T {
    return isDefined(x) ? x : defaultValue;
}

function test1(x: Maybe<string>) {
    let x1 = getOrElse(x, "Undefined");         // string
    let x2 = isDefined(x) ? x : "Undefined";    // string
    let x3 = isUndefined(x) ? "Undefined" : x;  // string
}

function test2(x: Maybe<number>) {
    let x1 = getOrElse(x, -1);         // number
    let x2 = isDefined(x) ? x : -1;    // number
    let x3 = isUndefined(x) ? -1 : x;  // number
}
```

### 使用 `--outFile` 合并 `AMD` 和 `System` 模块

在使用 `--module amd` 或者 `--module system` 的同时制定 `--outFile` 将会把所有参与编译的模块合并为单个包括了多个模块闭包的输出文件.

每一个模块都会根据其相对于 `rootDir` 的位置被计算出自己的模块名称.

#### 例子

```ts
// 文件 src/a.ts
import * as B from "./lib/b";
export function createA() {
    return B.createB();
}
```

```ts
// 文件 src/lib/b.ts
export function createB() {
    return { };
}
```

结果为:

```js
define("lib/b", ["require", "exports"], function (require, exports) {
    "use strict";
    function createB() {
        return {};
    }
    exports.createB = createB;
});
define("a", ["require", "exports", "lib/b"], function (require, exports, B) {
    "use strict";
    function createA() {
        return B.createB();
    }
    exports.createA = createA;
});
```

### 支持 SystemJS 使用 `default` 导入

像 SystemJS 这样的模块加载器将 CommonJS 模块做了包装并暴露为 `default` ES6 导入项. 这使得在 SystemJS 和 CommonJS 的实现由于不同加载器不同的模块导出方式不能共享定义.

设置新的编译选项 `--allowSyntheticDefaultImports` 指明模块加载器会进行导入的 `.ts` 或 `.d.ts` 中未指定的某种类型的默认导入项构建. 编译器会由此推断存在一个 `default` 导出项和整个模块自己一致.

此选项在 System 模块默认开启.

### 允许循环中被引用的 `let`/`const`

之前这样会报错, 现在由 TypeScript 1.8 支持.
循环中被函数引用的 `let`/`const` 声明现在会被输出为与 `let`/`const` 更新语义相符的代码.

#### 例子

```ts
let list = [];
for (let i = 0; i < 5; i++) {
    list.push(() => i);
}

list.forEach(f => console.log(f()));
```

被编译为:

```js
var list = [];
var _loop_1 = function(i) {
    list.push(function () { return i; });
};
for (var i = 0; i < 5; i++) {
    _loop_1(i);
}
list.forEach(function (f) { return console.log(f()); });
```

然后结果是:

```cmd
0
1
2
3
4
```

### 改进的 `for..in` 语句检查

过去 `for..in` 变量的类型被推断为 `any`, 这使得编译器忽略了 `for..in` 语句内的一些不合法的使用.

从 TypeScript 1.8 开始:

- 在 `for..in` 语句中的变量隐含类型为 `string`.
- 当一个有数字索引签名对应类型 `T` (比如一个数组) 的对象被一个 `for..in` 索引*有*数字索引签名并且*没有*字符串索引签名 (比如还是数组) 的对象的变量索引, 产生的值的类型为 `T`.

#### 例子

```ts
var a: MyObject[];
for (var x in a) {   // x 的隐含类型为 string
    var obj = a[x];  // obj 的类型为 MyObject
}
```

### 模块现在输出时会加上 `"use strict;"`

对于 ES6 来说模块始终以严格模式被解析, 但这一点过去对于非 ES6 目标在生成的代码中并没有遵循. 从 TypeScript 1.8 开始, 输出的模块总会为严格模式. 由于多数严格模式下的错误也是 TS 编译时的错误, 多数代码并不会有可见的改动, 但是这也意味着有一些东西可能在运行时没有征兆地失败, 比如赋值给 `NaN` 现在会有运行时错误. 你可以参考这篇 [MDN 上的文章](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mod) 查看详细的严格模式与非严格模式的区别列表.

### 使用 `--allowJs` 加入 `.js` 文件

经常在项目中会有外部的非 TypeScript 编写的源文件.
一种方式是将 JS 代码转换为 TS 代码, 但这时又希望将所有 JS 代码和新的 TS 代码的输出一起打包为一个文件.

`.js` 文件现在允许作为 `tsc` 的输入文件. TypeScript 编译器会检查 `.js` 输入文件的语法错误, 并根据 `--target` 和 `--module` 选项输出对应的代码.
输出也会和其他 `.ts` 文件一起. `.js` 文件的 source maps 也会像 `.ts` 文件一样被生成.

### 使用 `--reactNamespace` 自定义 JSX 工厂

在使用 `--jsx react` 的同时使用 `--reactNamespace <JSX 工厂名称>` 可以允许使用一个不同的 JSX 工厂代替默认的 `React`.

新的工厂名称会被用来调用 `createElement` 和 `__spread` 方法.

#### 例子

```ts
import {jsxFactory} from "jsxFactory";

var div = <div>Hello JSX!</div>
```

编译参数:

```shell
tsc --jsx react --reactNamespace jsxFactory --m commonJS
```

结果:

```js
"use strict";
var jsxFactory_1 = require("jsxFactory");
var div = jsxFactory_1.jsxFactory.createElement("div", null, "Hello JSX!");
```

### 基于 `this` 的类型收窄

TypeScript 1.8 为类和接口方法扩展了[用户定义的类型收窄函数](#用户定义的类型收窄函数).

`this is T` 现在是类或接口方法的合法的返回值类型标注.
当在类型收窄的位置使用时 (比如 `if` 语句), 函数调用表达式的目标对象的类型会被收窄为 `T`.

#### 例子

```ts
class FileSystemObject {
    isFile(): this is File { return this instanceof File; }
    isDirectory(): this is Directory { return this instanceof Directory;}
    isNetworked(): this is (Networked & this) { return this.networked; }
    constructor(public path: string, private networked: boolean) {}
}

class File extends FileSystemObject {
    constructor(path: string, public content: string) { super(path, false); }
}
class Directory extends FileSystemObject {
    children: FileSystemObject[];
}
interface Networked {
    host: string;
}

let fso: FileSystemObject = new File("foo/bar.txt", "foo");
if (fso.isFile()) {
    fso.content; // fso 是 File
}
else if (fso.isDirectory()) {
    fso.children; // fso 是 Directory
}
else if (fso.isNetworked()) {
    fso.host; // fso 是 networked
}
```

### 官方的 TypeScript NuGet 包

从 TypeScript 1.8 开始, 将为 TypeScript 编译器 (`tsc.exe`) 和 MSBuild 整合 (`Microsoft.TypeScript.targets` 和 `Microsoft.TypeScript.Tasks.dll`) 提供官方的 NuGet 包.

稳定版本可以在这里下载:

- [Microsoft.TypeScript.Compiler](https://www.nuget.org/packages/Microsoft.TypeScript.Compiler/)
- [Microsoft.TypeScript.MSBuild](https://www.nuget.org/packages/Microsoft.TypeScript.MSBuild/)

与此同时, 和[每日 npm 包](http://blogs.msdn.com/b/typescript/archive/2015/07/27/introducing-typescript-nightlies.aspx)对应的每日 NuGet 包可以在 https://myget.org 下载:

- [TypeScript-Preview](https://www.myget.org/gallery/typescript-preview)

### `tsc` 错误信息更美观

我们理解大量单色的输出并不直观. 颜色可以帮助识别信息的始末, 这些视觉上的线索在处理复杂的错误信息时非常重要.

通过传递 `--pretty` 命令行选项, TypeScript 会给出更丰富的输出, 包含错误发生的上下文.

![展示在 ConEmu 中美化之后的错误信息](https://raw.githubusercontent.com/wiki/Microsoft/TypeScript/images/new-in-typescript/pretty01.png)

### 高亮 VS 2015 中的 JSX 代码

在 TypeScript 1.8 中, JSX 标签现在可以在 Visual Studio 2015 中被分别和高亮.

![jsx](https://cloud.githubusercontent.com/assets/8052307/12271404/b875c502-b90f-11e5-93d8-c6740be354d1.png)

通过 `工具`->`选项`->`环境`->`字体与颜色` 页面在 `VB XML` 颜色和字体设置中还可以进一步改变字体和颜色来自定义.

### `--project` (`-p`) 选项现在接受任意文件路径

`--project` 命令行选项过去只接受包含了 `tsconfig.json` 文件的文件夹.
考虑到不同的构建场景, 应该允许 `--project` 指向任何兼容的 JSON 文件.
比如说, 一个用户可能会希望为 Node 5 编译 CommonJS 的 ES 2015, 为浏览器编译 AMD 的 ES5.
现在少了这项限制, 用户可以更容易地直接使用 `tsc` 管理不同的构建目标, 无需再通过一些奇怪的方式, 比如将多个 `tsconfig.json` 文件放在不同的目录中.

如果参数是一个路径, 行为保持不变 - 编译器会尝试在该目录下寻找名为 `tsconfig.json` 的文件.

### 允许 tsconfig.json 中的注释

为配置添加文档是很棒的! `tsconfig.json` 现在支持单行和多行注释.

```json
{
    "compilerOptions": {
        "target": "ES2015", // 跑在 node v5 上, 呀!
        "sourceMap": true   // 让调试轻松一些
    },
    /*
     * 排除的文件
     */
    "exclude": [
        "file.d.ts"
    ]
}
```

### 支持输出到 IPC 驱动的文件

TypeScript 1.8 允许用户将 `--outFile` 参数和一些特殊的文件系统对象一起使用, 比如命名的管道 (pipe), 设备 (devices) 等.

举个例子, 在很多与 Unix 相似的系统上, 标准输出流可以通过文件 `/dev/stdout` 访问.

```sh
tsc foo.ts --outFile /dev/stdout
```

这一特性也允许输出给其他命令.

比如说, 我们可以输出生成的 JavaScript 给一个像 [pretty-js](https://www.npmjs.com/package/pretty-js) 这样的格式美化工具:

```sh
tsc foo.ts --outFile /dev/stdout | pretty-js
```

### 改进了 Visual Studio 2015 中对 `tsconfig.json` 的支持

TypeScript 1.8 允许在任何种类的项目中使用 `tsconfig.json` 文件.
包括 ASP.NET v4 项目, *控制台应用*, 以及 *用 TypeScript 开发的 HTML 应用*.
与此同时, 你可以添加不止一个 `tsconfig.json` 文件, 其中每一个都会作为项目的一部分被构建.
这使得你可以在不使用多个不同项目的情况下为应用的不同部分使用不同的配置.

![展示 Visual Studio 中的 tsconfig.json](https://raw.githubusercontent.com/wiki/Microsoft/TypeScript/images/new-in-typescript/tsconfig-in-vs.png)

当项目中添加了 `tsconfig.json` 文件时, 我们还禁用了项目属性页面.
也就是说所有配置的改变必须在 `tsconfig.json` 文件中进行.

#### 一些限制

- 如果你添加了一个 `tsconfig.json` 文件, 不在其上下文中的 TypeScript 文件不会被编译.
- Apache Cordova 应用依然有单个 `tsconfig.json` 文件的限制, 而这个文件必须在根目录或者 `scripts` 文件夹.
- 多数项目类型中都没有 `tsconfig.json` 的模板.

## TypeScript 1.7

### 支持 `async`/`await` 编译到 ES6 (Node v4+)

TypeScript 目前在已经原生支持 ES6 generator 的引擎 (比如 Node v4 及以上版本) 上支持异步函数. 异步函数前置 `async` 关键字; `await` 会暂停执行, 直到一个异步函数执行后返回的 promise 被 fulfill 后获得它的值.

#### 例子

在下面的例子中, 输入的内容将会延时 200 毫秒逐个打印:

```ts
"use strict";

// printDelayed 返回值是一个 'Promise<void>'
async function printDelayed(elements: string[]) {
    for (const element of elements) {
        await delay(200);
        console.log(element);
    }
}

async function delay(milliseconds: number) {
    return new Promise<void>(resolve => {
        setTimeout(resolve, milliseconds);
    });
}

printDelayed(["Hello", "beautiful", "asynchronous", "world"]).then(() => {
    console.log();
    console.log("打印每一个内容!");
});
```

查看 [Async Functions](http://blogs.msdn.com/b/typescript/archive/2015/11/03/what-about-async-await.aspx) 一文了解更多.

### 支持同时使用 `--target ES6` 和 `--module`

TypeScript 1.7 将 `ES6` 添加到了 `--module` 选项支持的选项的列表, 当编译到 `ES6` 时允许指定模块类型. 这让使用具体运行时中你需要的特性更加灵活.

#### 例子

```json
{
    "compilerOptions": {
        "module": "amd",
        "target": "es6"
    }
}
```

### `this` 类型

在方法中返回当前对象 (也就是 `this`) 是一种创建链式 API 的常见方式. 比如, 考虑下面的 `BasicCalculator` 模块:

```ts
export default class BasicCalculator {
    public constructor(protected value: number = 0) { }

    public currentValue(): number {
        return this.value;
    }

    public add(operand: number) {
        this.value += operand;
        return this;
    }

    public subtract(operand: number) {
        this.value -= operand;
        return this;
    }

    public multiply(operand: number) {
        this.value *= operand;
        return this;
    }

    public divide(operand: number) {
        this.value /= operand;
        return this;
    }
}
```

使用者可以这样表述 `2 * 5 + 1`:

```ts
import calc from "./BasicCalculator";

let v = new calc(2)
    .multiply(5)
    .add(1)
    .currentValue();
```

这使得这么一种优雅的编码方式成为可能; 然而, 对于想要去继承 `BasicCalculator` 的类来说有一个问题. 想象使用者可能需要编写一个 `ScientificCalculator`:

```ts
import BasicCalculator from "./BasicCalculator";

export default class ScientificCalculator extends BasicCalculator {
    public constructor(value = 0) {
        super(value);
    }

    public square() {
        this.value = this.value ** 2;
        return this;
    }

    public sin() {
        this.value = Math.sin(this.value);
        return this;
    }
}
```

因为 `BasicCalculator` 的方法返回了 `this`, TypeScript 过去推断的类型是 `BasicCalculator`, 如果在 `ScientificCalculator` 的实例上调用属于 `BasicCalculator` 的方法, 类型系统不能很好地处理.

举例来说:

```ts
import calc from "./ScientificCalculator";

let v = new calc(0.5)
    .square()
    .divide(2)
    .sin()    // Error: 'BasicCalculator' 没有 'sin' 方法.
    .currentValue();
```

这已经不再是问题 - TypeScript 现在在类的实例方法中, 会将 `this` 推断为一个特殊的叫做 `this` 的类型. `this` 类型也就写作 `this`, 可以大致理解为 "方法调用时点左边的类型".

`this` 类型在描述一些使用了 mixin 风格继承的库 (比如 Ember.js) 的交叉类型:

```ts
interface MyType {
    extend<T>(other: T): this & T;
}
```

### ES7 幂运算符

TypeScript 1.7 支持将在 ES7/ES2016 中增加的[幂运算符](https://github.com/rwaldron/exponentiation-operator): `**` 和 `**=`. 这些运算符会被转换为 ES3/ES5 中的 `Math.pow`.

#### 举例

```ts
var x = 2 ** 3;
var y = 10;
y **= 2;
var z =  -(4 ** 3);
```

会生成下面的 JavaScript:

```ts
var x = Math.pow(2, 3);
var y = 10;
y = Math.pow(y, 2);
var z = -(Math.pow(4, 3));
```

### 改进对象字面量解构的检查

TypeScript 1.7 使对象和数组字面量解构初始值的检查更加直观和自然.

当一个对象字面量通过与之对应的对象解构绑定推断类型时:

- 对象解构绑定中有默认值的属性对于对象字面量来说可选.
- 对象解构绑定中的属性如果在对象字面量中没有匹配的值, 则该属性必须有默认值, 并且会被添加到对象字面量的类型中.
- 对象字面量中的属性必须在对象解构绑定中存在.

当一个数组字面量通过与之对应的数组解构绑定推断类型时:

- 数组解构绑定中的元素如果在数组字面量中没有匹配的值, 则该元素必须有默认值, 并且会被添加到数组字面量的类型中.

#### 举例

```ts
// f1 的类型为 (arg?: { x?: number, y?: number }) => void
function f1({ x = 0, y = 0 } = {}) { }

// And can be called as:
f1();
f1({});
f1({ x: 1 });
f1({ y: 1 });
f1({ x: 1, y: 1 });

// f2 的类型为 (arg?: (x: number, y?: number) => void
function f2({ x, y = 0 } = { x: 0 }) { }

f2();
f2({});        // 错误, x 非可选
f2({ x: 1 });
f2({ y: 1 });  // 错误, x 非可选
f2({ x: 1, y: 1 });
```

### 装饰器 (decorators) 支持的编译目标版本增加 ES3

装饰器现在可以编译到 ES3. TypeScript 1.7 在 `__decorate` 函数中移除了 ES5 中增加的 `reduceRight`. 相关改动也内联了对 `Object.getOwnPropertyDescriptor` 和 `Object.defineProperty` 的调用, 并向后兼容, 使 ES5 的输出可以消除前面提到的 `Object` 方法的重复<sup>[3]</sup>.

## TypeScript 1.6

### JSX 支持

JSX 是一种可嵌入的类似 XML 的语法. 它将最终被转换为合法的 JavaScript, 但转换的语义和具体实现有关. JSX 随着 React 流行起来, 也出现在其他应用中. TypeScript 1.6 支持 JavaScript 文件中 JSX 的嵌入, 类型检查, 以及直接编译为 JavaScript 的选项.

#### 新的 `.tsx` 文件扩展名和 `as` 运算符

TypeScript 1.6 引入了新的 `.tsx` 文件扩展名. 这一扩展名一方面允许 TypeScript 文件中的 JSX 语法, 一方面将 `as` 运算符作为默认的类型转换方式 (避免 JSX 表达式和 TypeScript 前置类型转换运算符之间的歧义). 比如:

```ts
var x = <any> foo;
// 与如下等价:
var x = foo as any;
```

#### 使用 React

使用 React 及 JSX 支持, 你需要使用 [React 类型声明](https://github.com/borisyankov/DefinitelyTyped/tree/master/react). 这些类型定义了 `JSX` 命名空间, 以便 TypeScript 能正确地检查 React 的 JSX 表达式. 比如:

```ts
/// <reference path="react.d.ts" />

interface Props {
  name: string;
}

class MyComponent extends React.Component<Props, {}> {
  render() {
    return <span>{this.props.foo}</span>
  }
}

<MyComponent name="bar" />; // 没问题
<MyComponent name={0} />; // 错误, `name` 不是一个数字
```

#### 使用其他 JSX 框架

JSX 元素的名称和属性是根据 `JSX` 命名空间来检验的. 请查看 [JSX](https://github.com/Microsoft/TypeScript/wiki/JSX) 页面了解如何为自己的框架定义 `JSX` 命名空间.

#### 编译输出

TypeScript 支持两种 `JSX` 模式: `preserve` (保留) 和 `react`.

- `preserve` 模式将会在输出中保留 JSX 表达式, 使之后的转换步骤可以处理. *并且输出的文件扩展名为 `.jsx`.*
- `react` 模式将会生成 `React.createElement`, 不再需要再通过 JSX 转换即可运行, 输出的文件扩展名为 `.js`.

查看 [JSX](https://github.com/Microsoft/TypeScript/wiki/JSX) 页面了解更多 JSX 在 TypeScript 中的使用.

### 交叉类型 (intersection types)

TypeScript 1.6 引入了交叉类型作为联合类型 (union types) 逻辑上的补充. 联合类型 `A | B` 表示一个类型为 `A` 或 `B` 的实体, 而交叉类型 `A & B` 表示一个类型同时为 `A` 或 `B` 的实体.

#### 例子

```ts
function extend<T, U>(first: T, second: U): T & U {
    let result = <T & U> {};
    for (let id in first) {
        result[id] = first[id];
    }
    for (let id in second) {
        if (!result.hasOwnProperty(id)) {
            result[id] = second[id];
        }
    }
    return result;
}

var x = extend({ a: "hello" }, { b: 42 });
var s = x.a;
var n = x.b;
```

```ts
type LinkedList<T> = T & { next: LinkedList<T> };

interface Person {
    name: string;
}

var people: LinkedList<Person>;
var s = people.name;
var s = people.next.name;
var s = people.next.next.name;
var s = people.next.next.next.name;
interface A { a: string }
interface B { b: string }
interface C { c: string }

var abc: A & B & C;
abc.a = "hello";
abc.b = "hello";
abc.c = "hello";
```

查看 [issue #1256](https://github.com/Microsoft/TypeScript/issues/1256) 了解更多.

### 本地类型声明

本地的类, 接口, 枚举和类型别名现在可以在函数声明中出现. 本地类型为块级作用域, 与 `let` 和 `const` 声明的变量类似. 比如说:

```ts
function f() {
    if (true) {
        interface T { x: number }
        let v: T;
        v.x = 5;
    }
    else {
        interface T { x: string }
        let v: T;
        v.x = "hello";
    }
}
```

推导出的函数返回值类型可能在函数内部声明的. 调用函数的地方无法引用到这样的本地类型, 但是它当然能从类型结构上匹配. 比如:

```ts
interface Point {
    x: number;
    y: number;
}

function getPointFactory(x: number, y: number) {
    class P {
        x = x;
        y = y;
    }
    return P;
}

var PointZero = getPointFactory(0, 0);
var PointOne = getPointFactory(1, 1);
var p1 = new PointZero();
var p2 = new PointZero();
var p3 = new PointOne();
```

本地的类型可以引用类型参数, 本地的类和接口本身即可能是泛型. 比如:

```ts
function f3() {
    function f<X, Y>(x: X, y: Y) {
        class C {
            public x = x;
            public y = y;
        }
        return C;
    }
    let C = f(10, "hello");
    let v = new C();
    let x = v.x;  // number
    let y = v.y;  // string
}
```

### 类表达式

TypeScript 1.6 增加了对 ES6 类表达式的支持. 在一个类表达式中, 类的名称是可选的, 如果指明, 作用域仅限于类表达式本身. 这和函数表达式可选的名称类似. 在类表达式外无法引用其实例类型, 但是自然也能够从类型结构上匹配. 比如:

```ts
let Point = class {
    constructor(public x: number, public y: number) { }
    public length() {
        return Math.sqrt(this.x * this.x + this.y * this.y);
    }
};
var p = new Point(3, 4);  // p has anonymous class type
console.log(p.length());
```

### 继承表达式

TypeScript 1.6 增加了对类继承任意值为一个构造函数的表达式的支持. 这样一来内建的类型也可以在类的声明中被继承.

`extends` 语句过去需要指定一个类型引用, 现在接受一个可选类型参数的表达式. 表达式的类型必须为有至少一个构造函数签名的构造函数, 并且需要和 `extends` 语句中类型参数数量一致. 匹配的构造函数签名的返回值类型是类实例类型继承的基类型. 如此一来, 这使得普通的类和与类相似的表达式可以在 `extends` 语句中使用.

一些例子:

```ts
// 继承内建类

class MyArray extends Array<number> { }
class MyError extends Error { }

// 继承表达式类

class ThingA {
    getGreeting() { return "Hello from A"; }
}

class ThingB {
    getGreeting() { return "Hello from B"; }
}

interface Greeter {
    getGreeting(): string;
}

interface GreeterConstructor {
    new (): Greeter;
}

function getGreeterBase(): GreeterConstructor {
    return Math.random() >= 0.5 ? ThingA : ThingB;
}

class Test extends getGreeterBase() {
    sayHello() {
        console.log(this.getGreeting());
    }
}
```

### `abstract` (抽象的) 类和方法

TypeScript 1.6 为类和它们的方法增加了 `abstract` 关键字. 一个抽象类允许没有被实现的方法, 并且不能被构造.

#### 例子

```ts
abstract class Base {
    abstract getThing(): string;
    getOtherThing() { return 'hello'; }
}

let x = new Base(); // 错误, 'Base' 是抽象的

// 错误, 必须也为抽象类, 或者实现 'getThing' 方法
class Derived1 extends Base { }

class Derived2 extends Base {
    getThing() { return 'hello'; }
    foo() {
        super.getThing();// 错误: 不能调用 'super' 的抽象方法
    }
}

var x = new Derived2(); // 正确
var y: Base = new Derived2(); // 同样正确
y.getThing(); // 正确
y.getOtherThing(); // 正确
```

### 泛型别名

TypeScript 1.6 中, 类型别名支持泛型. 比如:

```ts
type Lazy<T> = T | (() => T);

var s: Lazy<string>;
s = "eager";
s = () => "lazy";

interface Tuple<A, B> {
    a: A;
    b: B;
}

type Pair<T> = Tuple<T, T>;
```

### 更严格的对象字面量赋值检查

为了能发现多余或者错误拼写的属性, TypeScript 1.6 使用了更严格的对象字面量检查. 确切地说, 在将一个新的对象字面量赋值给一个变量, 或者传递给类型非空的参数时, 如果对象字面量的属性在目标类型中不存在, 则会视为错误.

#### 例子

```ts
var x: { foo: number };
x = { foo: 1, baz: 2 };  // 错误, 多余的属性 `baz`

var y: { foo: number, bar?: number };
y = { foo: 1, baz: 2 };  // 错误, 多余或者拼错的属性 `baz`
```

一个类型可以通过包含一个索引签名来现实指明未出现在类型中的属性是被允许的.

```ts
var x: { foo: number, [x: string]: any };
x = { foo: 1, baz: 2 };  // 现在 `baz` 匹配了索引签名
```

### ES6 生成器 (generators)

TypeScript 1.6 添加了对于 ES6 输出的生成器支持.

一个生成器函数可以有返回值类型标注, 就像普通的函数. 标注表示生成器函数返回的生成器的类型. 这里有个例子:

```ts
function *g(): Iterable<string> {
    for (var i = 0; i < 100; i++) {
        yield ""; // string 可以赋值给 string
    }
    yield * otherStringGenerator(); // otherStringGenerator 必须可遍历, 并且元素类型需要可赋值给 string
}
```

没有标注类型的生成器函数会有自动推演的类型. 在下面的例子中, 类型会由 yield 语句推演出来:

```ts
function *g() {
    for (var i = 0; i < 100; i++) {
        yield ""; // 推导出 string
    }
    yield * otherStringGenerator(); // 推导出 otherStringGenerator 的元素类型
}
```

### 对 `async` (异步) 函数的试验性支持

TypeScript 1.6 增加了编译到 ES6 时对 `async` 函数试验性的支持. 异步函数会执行一个异步的操作, 在等待的同时不会阻塞程序的正常运行. 这是通过与 ES6 兼容的 `Promise` 实现完成的, 并且会将函数体转换为支持在等待的异步操作完成时继续的形式.

由 `async` 标记的函数或方法被称作_异步函数_. 这个标记告诉了编译器该函数体需要被转换, 关键字 _await_ 则应该被当做一个一元运算符, 而不是标示符. 一个_异步函数_必须返回类型与 `Promise` 兼容的值. 返回值类型的推断只能在有一个全局的, 与 ES6 兼容的 `Promise` 类型时使用.

#### 例子

```ts
var p: Promise<number> = /* ... */;
async function fn(): Promise<number> {
  var i = await p; // 暂停执行知道 'p' 得到结果. 'i' 的类型为 "number"
  return 1 + i;
}

var a = async (): Promise<number> => 1 + await p; // 暂停执行.
var a = async () => 1 + await p; // 暂停执行. 使用 --target ES6 选项编译时返回值类型被推断为 "Promise<number>"
var fe = async function(): Promise<number> {
  var i = await p; // 暂停执行知道 'p' 得到结果. 'i' 的类型为 "number"
  return 1 + i;
}

class C {
  async m(): Promise<number> {
    var i = await p; // 暂停执行知道 'p' 得到结果. 'i' 的类型为 "number"
    return 1 + i;
  }

  async get p(): Promise<number> {
    var i = await p; // 暂停执行知道 'p' 得到结果. 'i' 的类型为 "number"
    return 1 + i;
  }
}
```

### 每天发布新版本

由于并不算严格意义上的语言变化<sup>[4]</sup>, 每天的新版本可以使用如下命令安装获得:

```sh
npm install -g typescript@next
```

### 对模块解析逻辑的调整

从 1.6 开始, TypeScript 编译器对于 "commonjs" 的模块解析会使用一套不同的规则. 这些[规则](https://github.com/Microsoft/TypeScript/issues/2338) 尝试模仿 Node 查找模块的过程. 这就意味着 node 模块可以包含它的类型信息, 并且 TypeScript 编译器可以找到这些信息. 不过用户可以通过使用 `--moduleResolution` 命令行选项覆盖模块解析规则. 支持的值有:

- 'classic' - TypeScript 1.6 以前的编译器使用的模块解析规则
- 'node' - 与 node 相似的模块解析

### 合并外围类和接口的声明

外围类的实例类型可以通过接口声明来扩展. 类构造函数对象不会被修改. 比如说:

```ts
declare class Foo {
    public x : number;
}

interface Foo {
    y : string;
}

function bar(foo : Foo)  {
    foo.x = 1; // 没问题, 在类 Foo 中有声明
    foo.y = "1"; // 没问题, 在接口 Foo 中有声明
}
```

### 用户定义的类型收窄函数

TypeScript 1.6 增加了一个新的在 `if` 语句中收窄变量类型的方式, 作为对 `typeof` 和 `instanceof` 的补充. 用户定义的类型收窄函数的返回值类型标注形式为 `x is T`, 这里 `x` 是函数声明中的形参, `T` 是任何类型. 当一个用户定义的类型收窄函数在 `if` 语句中被传入某个变量执行时, 该变量的类型会被收窄到 `T`.

#### 例子

```ts
function isCat(a: any): a is Cat {
  return a.name === 'kitty';
}

var x: Cat | Dog;
if(isCat(x)) {
  x.meow(); // 那么, x 在这个代码块内是 Cat 类型
}
```

### `tsconfig.json` 对 `exclude` 属性的支持

一个没有写明 `files` 属性的 `tsconfig.json` 文件 (默认会引用所有子目录下的 *.ts 文件) 现在可以包含一个 `exclude` 属性, 指定需要在编译中排除的文件或者目录列表. `exclude` 属性必须是一个字符串数组, 其中每一个元素指定对应的一个文件或者文件夹名称对于 `tsconfig.json` 文件所在位置的相对路径. 举例来说:

```json
{
    "compilerOptions": {
        "out": "test.js"
    },
    "exclude": [
        "node_modules",
        "test.ts",
        "utils/t2.ts"
    ]
}
```

`exclude` 列表不支持通配符. 仅仅可以是文件或者目录的列表.

### `--init` 命令行选项

在一个目录中执行 `tsc --init` 可以在该目录中创建一个包含了默认值的 `tsconfig.json`. 可以通过一并传递其他选项来生成初始的 `tsconfig.json`.

## TypeScript 1.5

### ES6 模块

TypeScript 1.5 支持 ECMAScript 6 (ES6) 模块. ES6 模块可以看做之前 TypeScript 的外部模块换上了新的语法: ES6 模块是分开加载的源文件, 这些文件还可能引入其他模块, 并且导出部分供外部可访问. ES6 模块新增了几种导入和导出声明. 我们建议使用 TypeScript 开发的库和应用能够更新到新的语法, 但不做强制要求. 新的 ES6 模块语法和 TypeScript 原来的内部和外部模块结构同时被支持, 如果需要也可以混合使用.

#### 导出声明

作为 TypeScript 已有的 `export` 前缀支持, 模块成员也可以使用单独导出的声明导出, 如果需要, `as` 语句可以指定不同的导出名称.

```ts
interface Stream { ... }
function writeToStream(stream: Stream, data: string) { ... }
export { Stream, writeToStream as write };  // writeToStream 导出为 write
```

引入声明也可以使用 `as` 语句来指定一个不同的导入名称. 比如:

```ts
import { read, write, standardOutput as stdout } from "./inout";
var s = read(stdout);
write(stdout, s);
```

作为单独导入的候选项, 命名空间导入可以导入整个模块:

```ts
import * as io from "./inout";
var s = io.read(io.standardOutput);
io.write(io.standardOutput, s);
```

### 重新导出

使用 `from` 语句一个模块可以复制指定模块的导出项到当前模块, 而无需创建本地名称.

```ts
export { read, write, standardOutput as stdout } from "./inout";
```

`export *` 可以用来重新导出另一个模块的所有导出项. 在创建一个聚合了其他几个模块导出项的模块时很方便.

```ts
export function transform(s: string): string { ... }
export * from "./mod1";
export * from "./mod2";
```

#### 默认导出项

一个 export default 声明表示一个表达式是这个模块的默认导出项.

```ts
export default class Greeter {
    sayHello() {
        console.log("Greetings!");
    }
}
```

对应的可以使用默认导入:

```ts
import Greeter from "./greeter";
var g = new Greeter();
g.sayHello();
```

#### 无导入加载

"无导入加载" 可以被用来加载某些只需要其副作用的模块.

```ts
import "./polyfills";
```

了解更多关于模块的信息, 请参见 [ES6 模块支持规范](https://github.com/Microsoft/TypeScript/issues/2242).

### 声明与赋值的解构

TypeScript 1.5 添加了对 ES6 解构声明与赋值的支持.

#### 解构

解构声明会引入一个或多个命名变量, 并且初始化它们的值为对象的属性或者数组的元素对应的值.

比如说, 下面的例子声明了变量 `x`, `y` 和 `z`, 并且分别将它们的值初始化为 `getSomeObject().x`, `getSomeObject().x` 和 `getSomeObject().x`:

```ts
var { x, y, z } = getSomeObject();
```

解构声明也可以用于从数组中得到值.

```ts
var [x, y, z = 10] = getSomeArray();
```

相似的, 解构可以用在函数的参数声明中:

```ts
function drawText({ text = "", location: [x, y] = [0, 0], bold = false }) {
    // 画出文本
}

// 以一个对象字面量为参数调用 drawText
var item = { text: "someText", location: [1,2,3], style: "italics" };
drawText(item);
```

#### 赋值

解构也可以被用于普通的赋值表达式. 举例来讲, 交换两个变量的值可以被写作一个解构赋值:

```ts
var x = 1;
var y = 2;
[x, y] = [y, x];
```

### `namespace` (命名空间) 关键字

过去 TypeScript 中 `module` 关键字既可以定义 "内部模块", 也可以定义 "外部模块"; 这让刚刚接触 TypeScript 的开发者有些困惑. "内部模块" 的概念更接近于大部分人眼中的命名空间; 而 "外部模块" 对于 JS 来讲, 现在也就是模块了.

> 注意: 之前定义内部模块的语法依然被支持.

**之前**:

```ts
module Math {
    export function add(x, y) { ... }
}
```

**之后**:

```ts
namespace Math {
    export function add(x, y) { ... }
}
```

### `let` 和 `const` 的支持

ES6 的 `let` 和 `const` 声明现在支持编译到 ES3 和 ES5.

#### Const

```ts
const MAX = 100;

++MAX; // 错误: 自增/减运算符不能用于一个常量
```

#### 块级作用域

```ts
if (true) {
  let a = 4;
  // 使用变量 a
}
else {
  let a = "string";
  // 使用变量 a
}

alert(a); // 错误: 变量 a 在当前作用域未定义
```

### `for...of` 的支持

TypeScript 1.5 增加了 ES6 `for...of` 循环编译到 ES3/ES5 时对数组的支持, 以及编译到 ES6 时对满足 `Iterator` 接口的全面支持.

#### 例子:

TypeScript 编译器会转译 `for...of` 数组到具有语义的 ES3/ES5 JavaScript (如果被设置为编译到这些版本).

```ts
for (var v of expr) { }
```

会输出为:

```js
for (var _i = 0, _a = expr; _i < _a.length; _i++) {
    var v = _a[_i];
}
```

### 装饰器

> TypeScript 装饰器是局域 [ES7 装饰器](https://github.com/wycats/javascript-decorators) 提案的.

一个装饰器是:

- 一个表达式
- 并且值为一个函数
- 接受 `target`, `name`, 以及属性描述对象作为参数
- 可选返回一个会被应用到目标对象的属性描述对象

> 了解更多, 请参见 [装饰器](https://github.com/Microsoft/TypeScript/issues/2249) 提案.

#### 例子:

装饰器 `readonly` 和 `enumerable(false)` 会在属性 `method` 添加到类 `C` 上之前被应用. 这使得装饰器可以修改其实现, 具体到这个例子, 设置了 `descriptor` 为 `writable: false` 以及 `enumerable: false`.

```ts
class C {
  @readonly
  @enumerable(false)
  method() { }
}

function readonly(target, key, descriptor) {
    descriptor.writable = false;
}

function enumerable(value) {
  return function (target, key, descriptor) {
     descriptor.enumerable = value;
  }
}
```

### 计算属性

使用动态的属性初始化一个对象可能会很麻烦. 参考下面的例子:

```ts
type NeighborMap = { [name: string]: Node };
type Node = { name: string; neighbors: NeighborMap;}

function makeNode(name: string, initialNeighbor: Node): Node {
    var neighbors: NeighborMap = {};
    neighbors[initialNeighbor.name] = initialNeighbor;
    return { name: name, neighbors: neighbors };
}
```

这里我们需要创建一个包含了 neighbor-map 的变量, 便于我们初始化它. 使用 TypeScript 1.5, 我们可以让编译器来干重活:

```ts
function makeNode(name: string, initialNeighbor: Node): Node {
    return {
        name: name,
        neighbors: {
            [initialNeighbor.name]: initialNeighbor
        }
    }
}
```

### 指出 `UMD` 和 `System` 模块输出

作为 `AMD` 和 `CommonJS` 模块加载器的补充, TypeScript 现在支持输出为 `UMD` ([Universal Module Definition](https://github.com/umdjs/umd)) 和 [`System`](https://github.com/systemjs/systemjs) 模块的格式.

**用法**:

> tsc --module umd

以及

> tsc --module system


### Unicode 字符串码位转义

ES6 中允许用户使用单个转义表示一个 Unicode 码位.

举个例子, 考虑我们需要转义一个包含了字符 '𠮷' 的字符串. 在 UTF-16/USC2 中, '𠮷' 被表示为一个代理对, 意思就是它被编码为一对 16 位值的代码单元, 具体来说是 `0xD842` 和 `0xDFB7`. 之前这意味着你必须将该码位转义为 `"\uD842\uDFB7"`. 这样做有一个重要的问题, 就事很难讲两个独立的字符同一个代理对区分开来.

通过 ES6 的码位转义, 你可以在字符串或模板字符串中清晰地通过一个转义表示一个确切的字符: `"\u{20bb7}"`. TypeScript 在编译到 ES3/ES5 时会将该字符串输出为 `"\uD842\uDFB7"`.

### 标签模板字符串编译到 ES3/ES5

TypeScript 1.4 中, 我们添加了模板字符串编译到所有 ES 版本的支持, 并且支持标签模板字符串编译到 ES6. 得益于 [@ivogabe](https://github.com/ivogabe) 的大量付出, 我们填补了标签模板字符串对编译到 ES3/ES5 的支持.

当编译到 ES3/ES5 时, 下面的代码:

```ts
function oddRawStrings(strs: TemplateStringsArray, n1, n2) {
    return strs.raw.filter((raw, index) => index % 2 === 1);
}

oddRawStrings `Hello \n${123} \t ${456}\n world`
```

会被输出为:

```ts
function oddRawStrings(strs, n1, n2) {
    return strs.raw.filter(function (raw, index) {
        return index % 2 === 1;
    });
}
(_a = ["Hello \n", " \t ", "\n world"], _a.raw = ["Hello \\n", " \\t ", "\\n world"], oddRawStrings(_a, 123, 456));
var _a;
```

### AMD 可选依赖名称

`/// <amd-dependency path="x" />` 会告诉编译器需要被注入到模块 `require` 方法中的非 TS 模块依赖; 然而在 TS 代码中无法使用这个模块.

新的 `amd-dependency name` 属性允许为 AMD 依赖传递一个可选的名称.

```ts
/// <amd-dependency path="legacy/moduleA" name="moduleA"/>
declare var moduleA:MyType
moduleA.callStuff()
```

生成的 JS 代码:

```ts
define(["require", "exports", "legacy/moduleA"], function (require, exports, moduleA) {
    moduleA.callStuff()
});
```

### 通过 `tsconfig.json` 指示一个项目

通过添加 `tsconfig.json` 到一个目录指明这是一个 TypeScript 项目的根目录. `tsconfig.json` 文件指定了根文件以及编译项目需要的编译器选项. 一个项目可以由以下方式编译:

- 调用 tsc 并不指定输入文件, 此时编译器会从当前目录开始往上级目录寻找 `tsconfig.json` 文件.
- 调用 tsc 并不指定输入文件, 使用 `-project` (或者 `-p`) 命令行选项指定包含了 `tsconfig.json` 文件的目录.

#### 例子:
```json
{
    "compilerOptions": {
        "module": "commonjs",
        "noImplicitAny": true,
        "sourceMap": true,
    }
}
```

参见 [tsconfig.json wiki 页面](https://github.com/Microsoft/TypeScript/wiki/tsconfig.json) 查看更多信息.

### `--rootDir` 命令行选项

选项 `--outDir` 在输出中会保留输入的层级关系. 编译器将所有输入文件共有的最长路径作为根路径; 并且在输出中应用对应的子层级关系.

有的时候这并不是期望的结果, 比如输入 `FolderA/FolderB/1.ts` 和 `FolderA/FolderB/2.ts`, 输出结构会是 `FolderA/FolderB/` 对应的结构. 如果输入中新增 `FolderA/3.ts` 文件, 输出的结构将突然变为 `FolderA/` 对应的结构.

`--rootDir` 指定了会输出对应结构的输入目录, 不再通过计算获得.

### `--noEmitHelpers` 命令行选项

TypeScript 编译器在需要的时候会输出一些像 `__extends` 这样的工具函数. 这些函数会在使用它们的所有文件中输出. 如果你想要聚合所有的工具函数到同一个位置, 或者覆盖默认的行为, 使用 `--noEmitHelpers` 来告知编译器不要输出它们.

### `--newLine` 命令行选项

默认输出的换行符在 Windows 上是 `\r\n`, 在 *nix 上是 `\n`. `--newLine` 命令行标记可以覆盖这个行为, 并指定输出文件中使用的换行符.

### `--inlineSourceMap` and `inlineSources` 命令行选项

`--inlineSourceMap` 将内嵌源文件映射到 `.js` 文件, 而不是在单独的 `.js.map` 文件中. `--inlineSources` 允许进一步将 `.ts` 文件内容包含到输出文件中.

## TypeScript 1.4

### 联合类型

#### 概览

联合类型是描述一个可能是几个类型之一的值的有效方式. 举例来说, 你可能会有一个 API 用于执行一个 `commandline` 为 `string`, `string[]` 或者是返回值为 `string` 的函数的程序. 现在可以这样写:

```ts
interface RunOptions {
   program: string;
   commandline: string[]|string|(() => string);
}
```

对联合类型的赋值非常直观 -- 任何可以赋值给联合类型中任意一个类型的值都可以赋值给这个联合类型:

```ts
var opts: RunOptions = /* ... */;
opts.commandline = '-hello world'; // 没问题
opts.commandline = ['-hello', 'world']; // 没问题
opts.commandline = [42]; // 错误, number 不是 string 或 string[]
```

当从联合类型中读取时, 你可以看到联合类型中各类型共有的属性:

```ts
if (opts.length === 0) { // 没问题, string 和 string[] 都有 'length' 属性
  console.log("it's empty");
}
```

使用类型收窄, 你可以方便的使用具有联合类型的变量:

```ts
function formatCommandline(c: string|string[]) {
    if (typeof c === 'string') {
        return c.trim();
    } else {
        return c.join(' ');
    }
}
```

#### 更严格的泛型

结合联合类型可以表示很多种类型场景, 我们决定让某些泛型调用更加严格. 之前, 以下的代码能出人意料地无错通过编译:

```ts
function equal<T>(lhs: T, rhs: T): boolean {
  return lhs === rhs;
}

// 过去: 无错误
// 现在: 错误, 'string' 和 'number' 间没有最佳共有类型
var e = equal(42, 'hello');
```

而通过联合类型, 你现在可以在函数声明或者调用的时候指明想要的行为:

```ts
// 'choose' 函数的参数类型必须相同
function choose1<T>(a: T, b: T): T { return Math.random() > 0.5 ? a : b }
var a = choose1('hello', 42); // 错误
var b = choose1<string|number>('hello', 42); // 正确

// 'choose' 函数的参数类型不需要相同
function choose2<T, U>(a: T, b: U): T|U { return Math.random() > 0.5 ? a : b }
var c = choose2('bar', 'foo'); // 正确, c: string
var d = choose2('hello', 42); // 正确, d: string|number
```

#### 更好的类型接口

联合类型也允许了数组或者其他地方有更好的类型接口, 以便一个集合中可能有多重类型.

```ts
var x = [1, 'hello']; // x: Array<string|number>
x[0] = 'world'; // 正确
x[0] = false; // 错误, boolean 不是 string 或 number
```

### `let` 声明

在 JavaScript 中, `var` 声明会被 "提升" 到它们所在的作用域. 这可能会导致一些令人疑惑的问题:

```ts
console.log(x); // 本意是在这里写 'y'
/* 当前代码块靠后的位置 */
var x = 'hello';
```

ES6 的关键字 `let` 现在在 TypeScript 中得到支持, 声明变量获得了更直观的块级语义. 一个 `let` 变量只能在它声明之后被引用, 其作用域被限定于它被声明的句法块:

```ts
if (foo) {
    console.log(x); // 错误, 在声明前不能引用 x
    let x = 'hello';
} else {
    console.log(x); // 错误, x 在当前块中没有声明
}
```

`let` 仅在编译到 ECMAScript 6 时被支持 (`--target ES6`).

### `const` 声明

另外一种在 TypeScript 中被支持的新的 ES6 声明类型是 `const`. 一个 `const` 变量不能被赋值, 并且在声明的时候必须被初始化. 这可以用在你声明和初始化后不希望值被改变时:

```ts
const halfPi = Math.PI / 2;
halfPi = 2; // 错误, 不能赋值给一个 `const`
```

`const` 仅在编译到 ECMAScript 6 时被支持 (`--target ES6`).

## 模板字符串

TypeScript 现在支持 ES6 模板字符串. 现在可以方便地在字符串中嵌入任何表达式:

```ts
var name = "TypeScript";
var greeting  = `Hello, ${name}! Your name has ${name.length} characters`;
```

当编译到 ES6 以前的版本时, 字符串会被分解为:

```ts
var name = "TypeScript!";
var greeting = "Hello, " + name + "! Your name has " + name.length + " characters";
```

### 类型收窄

在 JavaScript 中常常用 `typeof` 或者 `instanceof` 在运行时检查一个表达式的类型. TypeScript 现在理解这些条件, 并且在 `if` 语句中会据此改变类型接口.

使用 `typeof` 来检查一个变量:

```ts
var x: any = /* ... */;
if(typeof x === 'string') {
    console.log(x.subtr(1)); // 错误, 'subtr' 在 'string' 上不存在
}
// 这里 x 的类型依然是 any
x.unknown(); // 正确
```

与联合类型和 `else` 一起使用 `typeof`:

```ts
var x: string | HTMLElement = /* ... */;
if (typeof x === 'string') {
    // x 如上所述是一个 string
} else {
    // x 在这里是 HTMLElement
    console.log(x.innerHTML);
}
```

与类和联合类型一起使用 `instanceof`:

```ts
class Dog { woof() { } }
class Cat { meow() { } }
var pet: Dog | Cat = /* ... */;
if (pet instanceof Dog) {
    pet.woof(); // 正确
} else {
    pet.woof(); // 错误
}
```

### 类型别名

现在你可以使用 `type` 关键字为类型定义一个_别名_:

```ts
type PrimitiveArray = Array<string | number | boolean>;
type MyNumber = number;
type NgScope = ng.IScope;
type Callback = () => void;
```

类型别名和它们原来的类型完全相同; 它们仅仅是另一种表述的名称.

### `const enum` (完全内联的枚举)

枚举非常有用, 但有的程序可能并不需要生成的代码, 而简单地将枚举成员的数字值内联能够给这些程序带来一定好处. 新的 `const enum` 声明在类型安全上和 `enum` 一致, 但是编译后会被完全抹去.

```ts
const enum Suit { Clubs, Diamonds, Hearts, Spades }
var d = Suit.Diamonds;
```

编译为:

```js
var d = 1;
```

如果可能 TypeScript 现在会计算枚举的值:

```ts
enum MyFlags {
  None = 0,
  Neat = 1,
  Cool = 2,
  Awesome = 4,
  Best = Neat | Cool | Awesome
}
var b = MyFlags.Best; // 输出 var b = 7;
```

### `--noEmitOnError` 命令行选项

TypeScript 编译器的默认行为会在出现类型错误 (比如, 尝试赋值一个 `string` 给 `number`) 时依然输出 .js 文件. 在构建服务器或者其他只希望有 "干净" 版本的场景可能并不是期望的结果. 新的 `noEmitOnError` 标记会使编译器在有任何错误时不输出 .js 代码.

对于 MSBuild 的项目这是目前的默认设定; 这使 MSBuild 的增量编译变得可行, 输出仅在代码没有问题时产生.

### AMD 模块名称

AMD 模块默认生成是匿名的. 对于一些像打包工具这样的处理输出模块的工具会带来一些问题 (比如 r.js).

新的 `amd-module name` 标签允许传入一个可选的模块名称给编译器:

```ts
//// [amdModule.ts]
///<amd-module name='NamedModule'/>
export class C {
}
```

这会在调用 AMD 的 `define` 方法时传入名称 `NamedModule`:

```ts
//// [amdModule.js]
define("NamedModule", ["require", "exports"], function (require, exports) {
    var C = (function () {
        function C() {
        }
        return C;
    })();
    exports.C = C;
});
```

## TypeScript 1.3

### 受保护成员

在类中新的 `protected` 标示符就像它在其他一些像 C++, C# 与 Java 这样的常见语言中的功能一致. 一个 `protected` (受保护的) 的成员仅在子类或者声明它的类中可见:

```ts
class Thing {
  protected doSomething() { /* ... */ }
}

class MyThing extends Thing {
  public myMethod() {
    // 正确, 可以在子类中访问受保护成员
    this.doSomething();
  }
}
var t = new MyThing();
t.doSomething(); // 错误, 不能在类外调用受保护成员
```

### 元组类型

元组类型可以表示一个数组中部分元素的类型是已知, 但不一定相同的情况. 举例来说, 你可能希望描述一个数组, 在下标 0 处为 `string`, 在 1 处为 `number`:

```ts
// 声明一个元组类型
var x: [string, number];
// 初始化
x = ['hello', 10]; // 正确
// 错误的初始化
x = [10, 'hello']; // 错误
```

当使用已知的下标访问某个元素时, 能够获得正确的类型:

```ts
console.log(x[0].substr(1)); // 正确
console.log(x[1].substr(1)); // 错误, 'number' 类型没有 'substr' 属性
```

注意在 TypeScript 1.4 中, 当访问某个下标不在已知范围内的元素时, 获得的是联合类型:

```ts
x[3] = 'world'; // 正确
console.log(x[5].toString()); // 正确, 'string' 和 'number' 都有 toString 方法
x[6] = true; // 错误, boolean 不是 number 或 string
```

## TypeScript 1.1

### 性能优化

1.1 版编译器大体比之前任何版本快 4 倍. 查看 [这篇文章里令人印象深刻的对比](http://blogs.msdn.com/b/typescript/archive/2014/10/06/announcing-typescript-1-1-ctp.aspx).

### 更好的模块可见规则

TypeScript 现在仅在开启了 `--declaration` 标记时严格要求模块类型的可见性. 对于 Angular 的场景来说非常有用, 比如:

```ts
module MyControllers {
  interface ZooScope extends ng.IScope {
    animals: Animal[];
  }
  export class ZooController {
    // 过去是错误的 (无法暴露 ZooScope), 而现在仅在需要生成 .d.ts 文件时报错
    constructor(public $scope: ZooScope) { }
    /* 更多代码 */
  }
}
```

---

**[1]** 原文为 "A **mixin class** is a class declaration or expression that `extends` an expression of a type parameter type."

**[2]** 原文为 "Null- and undefined-aware types"

**[3]** 原文为 "The changes also inline calls `Object.getOwnPropertyDescriptor` and `Object.defineProperty` in a backwards-compatible fashion that allows for a to clean up the emit for ES5 and later by removing various repetitive calls to the aforementioned `Object` methods."

**[4]** 原文为 "While not strictly a language change..."

