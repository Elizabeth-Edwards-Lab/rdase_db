! function(t, e) {
    "object" == typeof exports && "object" == typeof module ? module.exports = e() : "function" == typeof define && define.amd ? define([], e) : "object" == typeof exports ? exports.Phylocanvas = e() : t.Phylocanvas = e()
}(this, function() {
    return function(t) {
        function e(r) {
            if (n[r]) return n[r].exports;
            var a = n[r] = {
                exports: {},
                id: r,
                loaded: !1
            };
            return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
        }
        var n = {};
        return e.m = t, e.c = n, e.p = "", e(0)
    }([function(t, e, n) {
        "use strict";

        function r(t) {
            return t && t.__esModule ? t : {
                default: t
            }
        }
        n(1);
        var a = n(2),
            i = r(a),
            o = n(4),
            s = r(o),
            l = n(5),
            c = r(l),
            h = n(6),
            u = r(h),
            f = n(7),
            d = r(f),
            C = n(3),
            v = r(C);
        v.default.plugin(i.default), v.default.plugin(s.default), v.default.plugin(c.default), v.default.plugin(u.default), v.default.plugin(d.default), t.exports = v.default
    }, function(t, e) {
        ! function(t) {
            function e(r) {
                if (n[r]) return n[r].exports;
                var a = n[r] = {
                    exports: {},
                    id: r,
                    loaded: !1
                };
                return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
            }
            var n = {};
            return e.m = t, e.c = n, e.p = "", e(0)
        }([function(t, e, n) {
            n(1), n(50), n(59), n(65), n(67), n(76)
        }, function(t, e, n) {
            "use strict";
            var r = n(2),
                a = n(3),
                i = n(4),
                o = n(6),
                s = n(16),
                l = n(20).KEY,
                c = n(5),
                h = n(21),
                u = n(22),
                f = n(17),
                d = n(23),
                C = n(24),
                v = n(25),
                p = n(27),
                g = n(40),
                y = n(43),
                b = n(10),
                m = n(30),
                x = n(14),
                w = n(15),
                S = n(44),
                k = n(47),
                L = n(49),
                _ = n(9),
                E = n(28),
                T = L.f,
                M = _.f,
                O = k.f,
                P = r.Symbol,
                A = r.JSON,
                F = A && A.stringify,
                j = "prototype",
                N = d("_hidden"),
                R = d("toPrimitive"),
                B = {}.propertyIsEnumerable,
                z = h("symbol-registry"),
                D = h("symbols"),
                I = h("op-symbols"),
                U = Object[j],
                H = "function" == typeof P,
                W = r.QObject,
                X = !W || !W[j] || !W[j].findChild,
                Y = i && c(function() {
                    return 7 != S(M({}, "a", {
                        get: function() {
                            return M(this, "a", {
                                value: 7
                            }).a
                        }
                    })).a
                }) ? function(t, e, n) {
                    var r = T(U, e);
                    r && delete U[e], M(t, e, n), r && t !== U && M(U, e, r)
                } : M,
                K = function(t) {
                    var e = D[t] = S(P[j]);
                    return e._k = t, e
                },
                Q = H && "symbol" == typeof P.iterator ? function(t) {
                    return "symbol" == typeof t
                } : function(t) {
                    return t instanceof P
                },
                G = function(t, e, n) {
                    return t === U && G(I, e, n), b(t), e = x(e, !0), b(n), a(D, e) ? (n.enumerable ? (a(t, N) && t[N][e] && (t[N][e] = !1), n = S(n, {
                        enumerable: w(0, !1)
                    })) : (a(t, N) || M(t, N, w(1, {})), t[N][e] = !0), Y(t, e, n)) : M(t, e, n)
                },
                V = function(t, e) {
                    b(t);
                    for (var n, r = g(e = m(e)), a = 0, i = r.length; i > a;) G(t, n = r[a++], e[n]);
                    return t
                },
                q = function(t, e) {
                    return void 0 === e ? S(t) : V(S(t), e)
                },
                Z = function(t) {
                    var e = B.call(this, t = x(t, !0));
                    return !(this === U && a(D, t) && !a(I, t)) && (!(e || !a(this, t) || !a(D, t) || a(this, N) && this[N][t]) || e)
                },
                J = function(t, e) {
                    if (t = m(t), e = x(e, !0), t !== U || !a(D, e) || a(I, e)) {
                        var n = T(t, e);
                        return !n || !a(D, e) || a(t, N) && t[N][e] || (n.enumerable = !0), n
                    }
                },
                $ = function(t) {
                    for (var e, n = O(m(t)), r = [], i = 0; n.length > i;) a(D, e = n[i++]) || e == N || e == l || r.push(e);
                    return r
                },
                tt = function(t) {
                    for (var e, n = t === U, r = O(n ? I : m(t)), i = [], o = 0; r.length > o;) !a(D, e = r[o++]) || n && !a(U, e) || i.push(D[e]);
                    return i
                };
            H || (P = function() {
                if (this instanceof P) throw TypeError("Symbol is not a constructor!");
                var t = f(arguments.length > 0 ? arguments[0] : void 0),
                    e = function(n) {
                        this === U && e.call(I, n), a(this, N) && a(this[N], t) && (this[N][t] = !1), Y(this, t, w(1, n))
                    };
                return i && X && Y(U, t, {
                    configurable: !0,
                    set: e
                }), K(t)
            }, s(P[j], "toString", function() {
                return this._k
            }), L.f = J, _.f = G, n(48).f = k.f = $, n(42).f = Z, n(41).f = tt, i && !n(26) && s(U, "propertyIsEnumerable", Z, !0), C.f = function(t) {
                return K(d(t))
            }), o(o.G + o.W + o.F * !H, {
                Symbol: P
            });
            for (var et = "hasInstance,isConcatSpreadable,iterator,match,replace,search,species,split,toPrimitive,toStringTag,unscopables".split(","), nt = 0; et.length > nt;) d(et[nt++]);
            for (var et = E(d.store), nt = 0; et.length > nt;) v(et[nt++]);
            o(o.S + o.F * !H, "Symbol", {
                for: function(t) {
                    return a(z, t += "") ? z[t] : z[t] = P(t)
                },
                keyFor: function(t) {
                    if (Q(t)) return p(z, t);
                    throw TypeError(t + " is not a symbol!")
                },
                useSetter: function() {
                    X = !0
                },
                useSimple: function() {
                    X = !1
                }
            }), o(o.S + o.F * !H, "Object", {
                create: q,
                defineProperty: G,
                defineProperties: V,
                getOwnPropertyDescriptor: J,
                getOwnPropertyNames: $,
                getOwnPropertySymbols: tt
            }), A && o(o.S + o.F * (!H || c(function() {
                var t = P();
                return "[null]" != F([t]) || "{}" != F({
                    a: t
                }) || "{}" != F(Object(t))
            })), "JSON", {
                stringify: function(t) {
                    if (void 0 !== t && !Q(t)) {
                        for (var e, n, r = [t], a = 1; arguments.length > a;) r.push(arguments[a++]);
                        return e = r[1], "function" == typeof e && (n = e), !n && y(e) || (e = function(t, e) {
                            if (n && (e = n.call(this, t, e)), !Q(e)) return e
                        }), r[1] = e, F.apply(A, r)
                    }
                }
            }), P[j][R] || n(8)(P[j], R, P[j].valueOf), u(P, "Symbol"), u(Math, "Math", !0), u(r.JSON, "JSON", !0)
        }, function(t, e) {
            var n = t.exports = "undefined" != typeof window && window.Math == Math ? window : "undefined" != typeof self && self.Math == Math ? self : Function("return this")();
            "number" == typeof __g && (__g = n)
        }, function(t, e) {
            var n = {}.hasOwnProperty;
            t.exports = function(t, e) {
                return n.call(t, e)
            }
        }, function(t, e, n) {
            t.exports = !n(5)(function() {
                return 7 != Object.defineProperty({}, "a", {
                    get: function() {
                        return 7
                    }
                }).a
            })
        }, function(t, e) {
            t.exports = function(t) {
                try {
                    return !!t()
                } catch (t) {
                    return !0
                }
            }
        }, function(t, e, n) {
            var r = n(2),
                a = n(7),
                i = n(8),
                o = n(16),
                s = n(18),
                l = "prototype",
                c = function(t, e, n) {
                    var h, u, f, d, C = t & c.F,
                        v = t & c.G,
                        p = t & c.S,
                        g = t & c.P,
                        y = t & c.B,
                        b = v ? r : p ? r[e] || (r[e] = {}) : (r[e] || {})[l],
                        m = v ? a : a[e] || (a[e] = {}),
                        x = m[l] || (m[l] = {});
                    v && (n = e);
                    for (h in n) u = !C && b && void 0 !== b[h], f = (u ? b : n)[h], d = y && u ? s(f, r) : g && "function" == typeof f ? s(Function.call, f) : f, b && o(b, h, f, t & c.U), m[h] != f && i(m, h, d), g && x[h] != f && (x[h] = f)
                };
            r.core = a, c.F = 1, c.G = 2, c.S = 4, c.P = 8, c.B = 16, c.W = 32, c.U = 64, c.R = 128, t.exports = c
        }, function(t, e) {
            var n = t.exports = {
                version: "2.4.0"
            };
            "number" == typeof __e && (__e = n)
        }, function(t, e, n) {
            var r = n(9),
                a = n(15);
            t.exports = n(4) ? function(t, e, n) {
                return r.f(t, e, a(1, n))
            } : function(t, e, n) {
                return t[e] = n, t
            }
        }, function(t, e, n) {
            var r = n(10),
                a = n(12),
                i = n(14),
                o = Object.defineProperty;
            e.f = n(4) ? Object.defineProperty : function(t, e, n) {
                if (r(t), e = i(e, !0), r(n), a) try {
                    return o(t, e, n)
                } catch (t) {}
                if ("get" in n || "set" in n) throw TypeError("Accessors not supported!");
                return "value" in n && (t[e] = n.value), t
            }
        }, function(t, e, n) {
            var r = n(11);
            t.exports = function(t) {
                if (!r(t)) throw TypeError(t + " is not an object!");
                return t
            }
        }, function(t, e) {
            t.exports = function(t) {
                return "object" == typeof t ? null !== t : "function" == typeof t
            }
        }, function(t, e, n) {
            t.exports = !n(4) && !n(5)(function() {
                return 7 != Object.defineProperty(n(13)("div"), "a", {
                    get: function() {
                        return 7
                    }
                }).a
            })
        }, function(t, e, n) {
            var r = n(11),
                a = n(2).document,
                i = r(a) && r(a.createElement);
            t.exports = function(t) {
                return i ? a.createElement(t) : {}
            }
        }, function(t, e, n) {
            var r = n(11);
            t.exports = function(t, e) {
                if (!r(t)) return t;
                var n, a;
                if (e && "function" == typeof(n = t.toString) && !r(a = n.call(t))) return a;
                if ("function" == typeof(n = t.valueOf) && !r(a = n.call(t))) return a;
                if (!e && "function" == typeof(n = t.toString) && !r(a = n.call(t))) return a;
                throw TypeError("Can't convert object to primitive value")
            }
        }, function(t, e) {
            t.exports = function(t, e) {
                return {
                    enumerable: !(1 & t),
                    configurable: !(2 & t),
                    writable: !(4 & t),
                    value: e
                }
            }
        }, function(t, e, n) {
            var r = n(2),
                a = n(8),
                i = n(3),
                o = n(17)("src"),
                s = "toString",
                l = Function[s],
                c = ("" + l).split(s);
            n(7).inspectSource = function(t) {
                return l.call(t)
            }, (t.exports = function(t, e, n, s) {
                var l = "function" == typeof n;
                l && (i(n, "name") || a(n, "name", e)), t[e] !== n && (l && (i(n, o) || a(n, o, t[e] ? "" + t[e] : c.join(String(e)))), t === r ? t[e] = n : s ? t[e] ? t[e] = n : a(t, e, n) : (delete t[e], a(t, e, n)))
            })(Function.prototype, s, function() {
                return "function" == typeof this && this[o] || l.call(this)
            })
        }, function(t, e) {
            var n = 0,
                r = Math.random();
            t.exports = function(t) {
                return "Symbol(".concat(void 0 === t ? "" : t, ")_", (++n + r).toString(36))
            }
        }, function(t, e, n) {
            var r = n(19);
            t.exports = function(t, e, n) {
                if (r(t), void 0 === e) return t;
                switch (n) {
                    case 1:
                        return function(n) {
                            return t.call(e, n)
                        };
                    case 2:
                        return function(n, r) {
                            return t.call(e, n, r)
                        };
                    case 3:
                        return function(n, r, a) {
                            return t.call(e, n, r, a)
                        }
                }
                return function() {
                    return t.apply(e, arguments)
                }
            }
        }, function(t, e) {
            t.exports = function(t) {
                if ("function" != typeof t) throw TypeError(t + " is not a function!");
                return t
            }
        }, function(t, e, n) {
            var r = n(17)("meta"),
                a = n(11),
                i = n(3),
                o = n(9).f,
                s = 0,
                l = Object.isExtensible || function() {
                    return !0
                },
                c = !n(5)(function() {
                    return l(Object.preventExtensions({}))
                }),
                h = function(t) {
                    o(t, r, {
                        value: {
                            i: "O" + ++s,
                            w: {}
                        }
                    })
                },
                u = function(t, e) {
                    if (!a(t)) return "symbol" == typeof t ? t : ("string" == typeof t ? "S" : "P") + t;
                    if (!i(t, r)) {
                        if (!l(t)) return "F";
                        if (!e) return "E";
                        h(t)
                    }
                    return t[r].i
                },
                f = function(t, e) {
                    if (!i(t, r)) {
                        if (!l(t)) return !0;
                        if (!e) return !1;
                        h(t)
                    }
                    return t[r].w
                },
                d = function(t) {
                    return c && C.NEED && l(t) && !i(t, r) && h(t), t
                },
                C = t.exports = {
                    KEY: r,
                    NEED: !1,
                    fastKey: u,
                    getWeak: f,
                    onFreeze: d
                }
        }, function(t, e, n) {
            var r = n(2),
                a = "__core-js_shared__",
                i = r[a] || (r[a] = {});
            t.exports = function(t) {
                return i[t] || (i[t] = {})
            }
        }, function(t, e, n) {
            var r = n(9).f,
                a = n(3),
                i = n(23)("toStringTag");
            t.exports = function(t, e, n) {
                t && !a(t = n ? t : t.prototype, i) && r(t, i, {
                    configurable: !0,
                    value: e
                })
            }
        }, function(t, e, n) {
            var r = n(21)("wks"),
                a = n(17),
                i = n(2).Symbol,
                o = "function" == typeof i,
                s = t.exports = function(t) {
                    return r[t] || (r[t] = o && i[t] || (o ? i : a)("Symbol." + t))
                };
            s.store = r
        }, function(t, e, n) {
            e.f = n(23)
        }, function(t, e, n) {
            var r = n(2),
                a = n(7),
                i = n(26),
                o = n(24),
                s = n(9).f;
            t.exports = function(t) {
                var e = a.Symbol || (a.Symbol = i ? {} : r.Symbol || {});
                "_" == t.charAt(0) || t in e || s(e, t, {
                    value: o.f(t)
                })
            }
        }, function(t, e) {
            t.exports = !1
        }, function(t, e, n) {
            var r = n(28),
                a = n(30);
            t.exports = function(t, e) {
                for (var n, i = a(t), o = r(i), s = o.length, l = 0; s > l;)
                    if (i[n = o[l++]] === e) return n
            }
        }, function(t, e, n) {
            var r = n(29),
                a = n(39);
            t.exports = Object.keys || function(t) {
                return r(t, a)
            }
        }, function(t, e, n) {
            var r = n(3),
                a = n(30),
                i = n(34)(!1),
                o = n(38)("IE_PROTO");
            t.exports = function(t, e) {
                var n, s = a(t),
                    l = 0,
                    c = [];
                for (n in s) n != o && r(s, n) && c.push(n);
                for (; e.length > l;) r(s, n = e[l++]) && (~i(c, n) || c.push(n));
                return c
            }
        }, function(t, e, n) {
            var r = n(31),
                a = n(33);
            t.exports = function(t) {
                return r(a(t))
            }
        }, function(t, e, n) {
            var r = n(32);
            t.exports = Object("z").propertyIsEnumerable(0) ? Object : function(t) {
                return "String" == r(t) ? t.split("") : Object(t)
            }
        }, function(t, e) {
            var n = {}.toString;
            t.exports = function(t) {
                return n.call(t).slice(8, -1)
            }
        }, function(t, e) {
            t.exports = function(t) {
                if (void 0 == t) throw TypeError("Can't call method on  " + t);
                return t
            }
        }, function(t, e, n) {
            var r = n(30),
                a = n(35),
                i = n(37);
            t.exports = function(t) {
                return function(e, n, o) {
                    var s, l = r(e),
                        c = a(l.length),
                        h = i(o, c);
                    if (t && n != n) {
                        for (; c > h;)
                            if (s = l[h++], s != s) return !0
                    } else
                        for (; c > h; h++)
                            if ((t || h in l) && l[h] === n) return t || h || 0;
                    return !t && -1
                }
            }
        }, function(t, e, n) {
            var r = n(36),
                a = Math.min;
            t.exports = function(t) {
                return t > 0 ? a(r(t), 9007199254740991) : 0
            }
        }, function(t, e) {
            var n = Math.ceil,
                r = Math.floor;
            t.exports = function(t) {
                return isNaN(t = +t) ? 0 : (t > 0 ? r : n)(t)
            }
        }, function(t, e, n) {
            var r = n(36),
                a = Math.max,
                i = Math.min;
            t.exports = function(t, e) {
                return t = r(t), t < 0 ? a(t + e, 0) : i(t, e)
            }
        }, function(t, e, n) {
            var r = n(21)("keys"),
                a = n(17);
            t.exports = function(t) {
                return r[t] || (r[t] = a(t))
            }
        }, function(t, e) {
            t.exports = "constructor,hasOwnProperty,isPrototypeOf,propertyIsEnumerable,toLocaleString,toString,valueOf".split(",")
        }, function(t, e, n) {
            var r = n(28),
                a = n(41),
                i = n(42);
            t.exports = function(t) {
                var e = r(t),
                    n = a.f;
                if (n)
                    for (var o, s = n(t), l = i.f, c = 0; s.length > c;) l.call(t, o = s[c++]) && e.push(o);
                return e
            }
        }, function(t, e) {
            e.f = Object.getOwnPropertySymbols
        }, function(t, e) {
            e.f = {}.propertyIsEnumerable
        }, function(t, e, n) {
            var r = n(32);
            t.exports = Array.isArray || function(t) {
                return "Array" == r(t)
            }
        }, function(t, e, n) {
            var r = n(10),
                a = n(45),
                i = n(39),
                o = n(38)("IE_PROTO"),
                s = function() {},
                l = "prototype",
                c = function() {
                    var t, e = n(13)("iframe"),
                        r = i.length,
                        a = "<",
                        o = ">";
                    for (e.style.display = "none", n(46).appendChild(e), e.src = "javascript:", t = e.contentWindow.document, t.open(), t.write(a + "script" + o + "document.F=Object" + a + "/script" + o), t.close(), c = t.F; r--;) delete c[l][i[r]];
                    return c()
                };
            t.exports = Object.create || function(t, e) {
                var n;
                return null !== t ? (s[l] = r(t), n = new s, s[l] = null, n[o] = t) : n = c(), void 0 === e ? n : a(n, e)
            }
        }, function(t, e, n) {
            var r = n(9),
                a = n(10),
                i = n(28);
            t.exports = n(4) ? Object.defineProperties : function(t, e) {
                a(t);
                for (var n, o = i(e), s = o.length, l = 0; s > l;) r.f(t, n = o[l++], e[n]);
                return t
            }
        }, function(t, e, n) {
            t.exports = n(2).document && document.documentElement
        }, function(t, e, n) {
            var r = n(30),
                a = n(48).f,
                i = {}.toString,
                o = "object" == typeof window && window && Object.getOwnPropertyNames ? Object.getOwnPropertyNames(window) : [],
                s = function(t) {
                    try {
                        return a(t)
                    } catch (t) {
                        return o.slice()
                    }
                };
            t.exports.f = function(t) {
                return o && "[object Window]" == i.call(t) ? s(t) : a(r(t))
            }
        }, function(t, e, n) {
            var r = n(29),
                a = n(39).concat("length", "prototype");
            e.f = Object.getOwnPropertyNames || function(t) {
                return r(t, a)
            }
        }, function(t, e, n) {
            var r = n(42),
                a = n(15),
                i = n(30),
                o = n(14),
                s = n(3),
                l = n(12),
                c = Object.getOwnPropertyDescriptor;
            e.f = n(4) ? c : function(t, e) {
                if (t = i(t), e = o(e, !0), l) try {
                    return c(t, e)
                } catch (t) {}
                if (s(t, e)) return a(!r.f.call(t, e), t[e])
            }
        }, function(t, e, n) {
            "use strict";
            var r = n(18),
                a = n(6),
                i = n(51),
                o = n(52),
                s = n(53),
                l = n(35),
                c = n(55),
                h = n(56);
            a(a.S + a.F * !n(58)(function(t) {
                Array.from(t)
            }), "Array", {
                from: function(t) {
                    var e, n, a, u, f = i(t),
                        d = "function" == typeof this ? this : Array,
                        C = arguments.length,
                        v = C > 1 ? arguments[1] : void 0,
                        p = void 0 !== v,
                        g = 0,
                        y = h(f);
                    if (p && (v = r(v, C > 2 ? arguments[2] : void 0, 2)), void 0 == y || d == Array && s(y))
                        for (e = l(f.length), n = new d(e); e > g; g++) c(n, g, p ? v(f[g], g) : f[g]);
                    else
                        for (u = y.call(f), n = new d; !(a = u.next()).done; g++) c(n, g, p ? o(u, v, [a.value, g], !0) : a.value);
                    return n.length = g, n
                }
            })
        }, function(t, e, n) {
            var r = n(33);
            t.exports = function(t) {
                return Object(r(t))
            }
        }, function(t, e, n) {
            var r = n(10);
            t.exports = function(t, e, n, a) {
                try {
                    return a ? e(r(n)[0], n[1]) : e(n)
                } catch (e) {
                    var i = t.return;
                    throw void 0 !== i && r(i.call(t)), e
                }
            }
        }, function(t, e, n) {
            var r = n(54),
                a = n(23)("iterator"),
                i = Array.prototype;
            t.exports = function(t) {
                return void 0 !== t && (r.Array === t || i[a] === t)
            }
        }, function(t, e) {
            t.exports = {}
        }, function(t, e, n) {
            "use strict";
            var r = n(9),
                a = n(15);
            t.exports = function(t, e, n) {
                e in t ? r.f(t, e, a(0, n)) : t[e] = n
            }
        }, function(t, e, n) {
            var r = n(57),
                a = n(23)("iterator"),
                i = n(54);
            t.exports = n(7).getIteratorMethod = function(t) {
                if (void 0 != t) return t[a] || t["@@iterator"] || i[r(t)]
            }
        }, function(t, e, n) {
            var r = n(32),
                a = n(23)("toStringTag"),
                i = "Arguments" == r(function() {
                    return arguments
                }()),
                o = function(t, e) {
                    try {
                        return t[e]
                    } catch (t) {}
                };
            t.exports = function(t) {
                var e, n, s;
                return void 0 === t ? "Undefined" : null === t ? "Null" : "string" == typeof(n = o(e = Object(t), a)) ? n : i ? r(e) : "Object" == (s = r(e)) && "function" == typeof e.callee ? "Arguments" : s
            }
        }, function(t, e, n) {
            var r = n(23)("iterator"),
                a = !1;
            try {
                var i = [7][r]();
                i.return = function() {
                    a = !0
                }, Array.from(i, function() {
                    throw 2
                })
            } catch (t) {}
            t.exports = function(t, e) {
                if (!e && !a) return !1;
                var n = !1;
                try {
                    var i = [7],
                        o = i[r]();
                    o.next = function() {
                        return {
                            done: n = !0
                        }
                    }, i[r] = function() {
                        return o
                    }, t(i)
                } catch (t) {}
                return n
            }
        }, function(t, e, n) {
            "use strict";
            var r = n(60),
                a = n(61),
                i = n(54),
                o = n(30);
            t.exports = n(62)(Array, "Array", function(t, e) {
                this._t = o(t), this._i = 0, this._k = e
            }, function() {
                var t = this._t,
                    e = this._k,
                    n = this._i++;
                return !t || n >= t.length ? (this._t = void 0, a(1)) : "keys" == e ? a(0, n) : "values" == e ? a(0, t[n]) : a(0, [n, t[n]])
            }, "values"), i.Arguments = i.Array, r("keys"), r("values"), r("entries")
        }, function(t, e, n) {
            var r = n(23)("unscopables"),
                a = Array.prototype;
            void 0 == a[r] && n(8)(a, r, {}), t.exports = function(t) {
                a[r][t] = !0
            }
        }, function(t, e) {
            t.exports = function(t, e) {
                return {
                    value: e,
                    done: !!t
                }
            }
        }, function(t, e, n) {
            "use strict";
            var r = n(26),
                a = n(6),
                i = n(16),
                o = n(8),
                s = n(3),
                l = n(54),
                c = n(63),
                h = n(22),
                u = n(64),
                f = n(23)("iterator"),
                d = !([].keys && "next" in [].keys()),
                C = "@@iterator",
                v = "keys",
                p = "values",
                g = function() {
                    return this
                };
            t.exports = function(t, e, n, y, b, m, x) {
                c(n, e, y);
                var w, S, k, L = function(t) {
                        if (!d && t in M) return M[t];
                        switch (t) {
                            case v:
                                return function() {
                                    return new n(this, t)
                                };
                            case p:
                                return function() {
                                    return new n(this, t)
                                }
                        }
                        return function() {
                            return new n(this, t)
                        }
                    },
                    _ = e + " Iterator",
                    E = b == p,
                    T = !1,
                    M = t.prototype,
                    O = M[f] || M[C] || b && M[b],
                    P = O || L(b),
                    A = b ? E ? L("entries") : P : void 0,
                    F = "Array" == e ? M.entries || O : O;
                if (F && (k = u(F.call(new t)), k !== Object.prototype && (h(k, _, !0), r || s(k, f) || o(k, f, g))), E && O && O.name !== p && (T = !0, P = function() {
                        return O.call(this)
                    }), r && !x || !d && !T && M[f] || o(M, f, P), l[e] = P, l[_] = g, b)
                    if (w = {
                            values: E ? P : L(p),
                            keys: m ? P : L(v),
                            entries: A
                        }, x)
                        for (S in w) S in M || i(M, S, w[S]);
                    else a(a.P + a.F * (d || T), e, w);
                return w
            }
        }, function(t, e, n) {
            "use strict";
            var r = n(44),
                a = n(15),
                i = n(22),
                o = {};
            n(8)(o, n(23)("iterator"), function() {
                return this
            }), t.exports = function(t, e, n) {
                t.prototype = r(o, {
                    next: a(1, n)
                }), i(t, e + " Iterator")
            }
        }, function(t, e, n) {
            var r = n(3),
                a = n(51),
                i = n(38)("IE_PROTO"),
                o = Object.prototype;
            t.exports = Object.getPrototypeOf || function(t) {
                return t = a(t), r(t, i) ? t[i] : "function" == typeof t.constructor && t instanceof t.constructor ? t.constructor.prototype : t instanceof Object ? o : null
            }
        }, function(t, e, n) {
            "use strict";
            var r = n(66)(!0);
            n(62)(String, "String", function(t) {
                this._t = String(t), this._i = 0
            }, function() {
                var t, e = this._t,
                    n = this._i;
                return n >= e.length ? {
                    value: void 0,
                    done: !0
                } : (t = r(e, n), this._i += t.length, {
                    value: t,
                    done: !1
                })
            })
        }, function(t, e, n) {
            var r = n(36),
                a = n(33);
            t.exports = function(t) {
                return function(e, n) {
                    var i, o, s = String(a(e)),
                        l = r(n),
                        c = s.length;
                    return l < 0 || l >= c ? t ? "" : void 0 : (i = s.charCodeAt(l), i < 55296 || i > 56319 || l + 1 === c || (o = s.charCodeAt(l + 1)) < 56320 || o > 57343 ? t ? s.charAt(l) : i : t ? s.slice(l, l + 2) : (i - 55296 << 10) + (o - 56320) + 65536)
                }
            }
        }, function(t, e, n) {
            "use strict";
            var r = n(68);
            t.exports = n(73)("Set", function(t) {
                return function() {
                    return t(this, arguments.length > 0 ? arguments[0] : void 0)
                }
            }, {
                add: function(t) {
                    return r.def(this, t = 0 === t ? 0 : t, t)
                }
            }, r)
        }, function(t, e, n) {
            "use strict";
            var r = n(9).f,
                a = n(44),
                i = n(69),
                o = n(18),
                s = n(70),
                l = n(33),
                c = n(71),
                h = n(62),
                u = n(61),
                f = n(72),
                d = n(4),
                C = n(20).fastKey,
                v = d ? "_s" : "size",
                p = function(t, e) {
                    var n, r = C(e);
                    if ("F" !== r) return t._i[r];
                    for (n = t._f; n; n = n.n)
                        if (n.k == e) return n
                };
            t.exports = {
                getConstructor: function(t, e, n, h) {
                    var u = t(function(t, r) {
                        s(t, u, e, "_i"), t._i = a(null), t._f = void 0, t._l = void 0, t[v] = 0, void 0 != r && c(r, n, t[h], t)
                    });
                    return i(u.prototype, {
                        clear: function() {
                            for (var t = this, e = t._i, n = t._f; n; n = n.n) n.r = !0, n.p && (n.p = n.p.n = void 0), delete e[n.i];
                            t._f = t._l = void 0, t[v] = 0
                        },
                        delete: function(t) {
                            var e = this,
                                n = p(e, t);
                            if (n) {
                                var r = n.n,
                                    a = n.p;
                                delete e._i[n.i], n.r = !0, a && (a.n = r), r && (r.p = a), e._f == n && (e._f = r), e._l == n && (e._l = a), e[v]--
                            }
                            return !!n
                        },
                        forEach: function(t) {
                            s(this, u, "forEach");
                            for (var e, n = o(t, arguments.length > 1 ? arguments[1] : void 0, 3); e = e ? e.n : this._f;)
                                for (n(e.v, e.k, this); e && e.r;) e = e.p
                        },
                        has: function(t) {
                            return !!p(this, t)
                        }
                    }), d && r(u.prototype, "size", {
                        get: function() {
                            return l(this[v])
                        }
                    }), u
                },
                def: function(t, e, n) {
                    var r, a, i = p(t, e);
                    return i ? i.v = n : (t._l = i = {
                        i: a = C(e, !0),
                        k: e,
                        v: n,
                        p: r = t._l,
                        n: void 0,
                        r: !1
                    }, t._f || (t._f = i), r && (r.n = i), t[v]++, "F" !== a && (t._i[a] = i)), t
                },
                getEntry: p,
                setStrong: function(t, e, n) {
                    h(t, e, function(t, e) {
                        this._t = t, this._k = e, this._l = void 0
                    }, function() {
                        for (var t = this, e = t._k, n = t._l; n && n.r;) n = n.p;
                        return t._t && (t._l = n = n ? n.n : t._t._f) ? "keys" == e ? u(0, n.k) : "values" == e ? u(0, n.v) : u(0, [n.k, n.v]) : (t._t = void 0, u(1))
                    }, n ? "entries" : "values", !n, !0), f(e)
                }
            }
        }, function(t, e, n) {
            var r = n(16);
            t.exports = function(t, e, n) {
                for (var a in e) r(t, a, e[a], n);
                return t
            }
        }, function(t, e) {
            t.exports = function(t, e, n, r) {
                if (!(t instanceof e) || void 0 !== r && r in t) throw TypeError(n + ": incorrect invocation!");
                return t
            }
        }, function(t, e, n) {
            var r = n(18),
                a = n(52),
                i = n(53),
                o = n(10),
                s = n(35),
                l = n(56),
                c = {},
                h = {},
                e = t.exports = function(t, e, n, u, f) {
                    var d, C, v, p, g = f ? function() {
                            return t
                        } : l(t),
                        y = r(n, u, e ? 2 : 1),
                        b = 0;
                    if ("function" != typeof g) throw TypeError(t + " is not iterable!");
                    if (i(g)) {
                        for (d = s(t.length); d > b; b++)
                            if (p = e ? y(o(C = t[b])[0], C[1]) : y(t[b]), p === c || p === h) return p
                    } else
                        for (v = g.call(t); !(C = v.next()).done;)
                            if (p = a(v, y, C.value, e), p === c || p === h) return p
                };
            e.BREAK = c, e.RETURN = h
        }, function(t, e, n) {
            "use strict";
            var r = n(2),
                a = n(9),
                i = n(4),
                o = n(23)("species");
            t.exports = function(t) {
                var e = r[t];
                i && e && !e[o] && a.f(e, o, {
                    configurable: !0,
                    get: function() {
                        return this
                    }
                })
            }
        }, function(t, e, n) {
            "use strict";
            var r = n(2),
                a = n(6),
                i = n(16),
                o = n(69),
                s = n(20),
                l = n(71),
                c = n(70),
                h = n(11),
                u = n(5),
                f = n(58),
                d = n(22),
                C = n(74);
            t.exports = function(t, e, n, v, p, g) {
                var y = r[t],
                    b = y,
                    m = p ? "set" : "add",
                    x = b && b.prototype,
                    w = {},
                    S = function(t) {
                        var e = x[t];
                        i(x, t, "delete" == t ? function(t) {
                            return !(g && !h(t)) && e.call(this, 0 === t ? 0 : t)
                        } : "has" == t ? function(t) {
                            return !(g && !h(t)) && e.call(this, 0 === t ? 0 : t)
                        } : "get" == t ? function(t) {
                            return g && !h(t) ? void 0 : e.call(this, 0 === t ? 0 : t)
                        } : "add" == t ? function(t) {
                            return e.call(this, 0 === t ? 0 : t), this
                        } : function(t, n) {
                            return e.call(this, 0 === t ? 0 : t, n), this
                        })
                    };
                if ("function" == typeof b && (g || x.forEach && !u(function() {
                        (new b).entries().next()
                    }))) {
                    var k = new b,
                        L = k[m](g ? {} : -0, 1) != k,
                        _ = u(function() {
                            k.has(1)
                        }),
                        E = f(function(t) {
                            new b(t)
                        }),
                        T = !g && u(function() {
                            for (var t = new b, e = 5; e--;) t[m](e, e);
                            return !t.has(-0)
                        });
                    E || (b = e(function(e, n) {
                        c(e, b, t);
                        var r = C(new y, e, b);
                        return void 0 != n && l(n, p, r[m], r), r
                    }), b.prototype = x, x.constructor = b), (_ || T) && (S("delete"), S("has"), p && S("get")), (T || L) && S(m), g && x.clear && delete x.clear
                } else b = v.getConstructor(e, t, p, m), o(b.prototype, n), s.NEED = !0;
                return d(b, t), w[t] = b, a(a.G + a.W + a.F * (b != y), w), g || v.setStrong(b, t, p), b
            }
        }, function(t, e, n) {
            var r = n(11),
                a = n(75).set;
            t.exports = function(t, e, n) {
                var i, o = e.constructor;
                return o !== n && "function" == typeof o && (i = o.prototype) !== n.prototype && r(i) && a && a(t, i), t
            }
        }, function(t, e, n) {
            var r = n(11),
                a = n(10),
                i = function(t, e) {
                    if (a(t), !r(e) && null !== e) throw TypeError(e + ": can't set as prototype!")
                };
            t.exports = {
                set: Object.setPrototypeOf || ("__proto__" in {} ? function(t, e, r) {
                    try {
                        r = n(18)(Function.call, n(49).f(Object.prototype, "__proto__").set, 2), r(t, []), e = !(t instanceof Array)
                    } catch (t) {
                        e = !0
                    }
                    return function(t, n) {
                        return i(t, n), e ? t.__proto__ = n : r(t, n), t
                    }
                }({}, !1) : void 0),
                check: i
            }
        }, function(t, e, n) {
            var r = n(6);
            r(r.S + r.F, "Object", {
                assign: n(77)
            })
        }, function(t, e, n) {
            "use strict";
            var r = n(28),
                a = n(41),
                i = n(42),
                o = n(51),
                s = n(31),
                l = Object.assign;
            t.exports = !l || n(5)(function() {
                var t = {},
                    e = {},
                    n = Symbol(),
                    r = "abcdefghijklmnopqrst";
                return t[n] = 7, r.split("").forEach(function(t) {
                    e[t] = t
                }), 7 != l({}, t)[n] || Object.keys(l({}, e)).join("") != r
            }) ? function(t, e) {
                for (var n = o(t), l = arguments.length, c = 1, h = a.f, u = i.f; l > c;)
                    for (var f, d = s(arguments[c++]), C = h ? r(d).concat(h(d)) : r(d), v = C.length, p = 0; v > p;) u.call(d, f = C[p++]) && (n[f] = d[f]);
                return n
            } : l
        }])
    }, function(t, e, n) {
        ! function(e, r) {
            t.exports = r(n(3))
        }(this, function(t) {
            return function(t) {
                function e(r) {
                    if (n[r]) return n[r].exports;
                    var a = n[r] = {
                        exports: {},
                        id: r,
                        loaded: !1
                    };
                    return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
                }
                var n = {};
                return e.m = t, e.c = n, e.p = "", e(0)
            }([function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), n(1);
                var a = n(5),
                    i = r(a);
                e.default = i.default
            }, function(t, e, n) {
                var r = n(2);
                "string" == typeof r && (r = [
                    [t.id, r, ""]
                ]), n(4)(r, {}), r.locals && (t.exports = r.locals)
            }, function(t, e, n) {
                e = t.exports = n(3)(), e.push([t.id, '.phylocanvas-history{position:absolute;top:0;bottom:0;left:0;box-sizing:border-box;width:240px;background:#fff;-webkit-transform:translateX(-240px);transform:translateX(-240px);-webkit-transform-style:preserve-3d;transform-style:preserve-3d;will-change:transform;-webkit-transition-duration:.2s;transition-duration:.2s;-webkit-transition-timing-function:cubic-bezier(.4,0,.2,1);transition-timing-function:cubic-bezier(.4,0,.2,1);-webkit-transition-property:-webkit-transform;transition-property:-webkit-transform;transition-property:transform;transition-property:transform,-webkit-transform;border:1px solid #e7e7e7;border-left:none}.phylocanvas-history--open{-webkit-transform:translateX(0);transform:translateX(0);box-shadow:0 2px 2px 0 rgba(0,0,0,.14),0 3px 1px -2px rgba(0,0,0,.2),0 1px 5px 0 rgba(0,0,0,.12)}.phylocanvas-history-button{border:none;height:24px;line-height:24px;text-align:center;margin:auto;min-width:56px;width:56px;padding:0;overflow:hidden;background:#3c7383;color:#fff;box-shadow:0 1px 1.5px 0 rgba(0,0,0,.12),0 1px 1px 0 rgba(0,0,0,.24);position:relative;line-height:normal;position:absolute;bottom:16px;right:-57px;z-index:1;outline:none;cursor:pointer;border-radius:0 0 2px 2px;font-size:13px;font-family:Helvetica,Arial,sans-serif;-webkit-transform:rotate(-90deg);transform:rotate(-90deg);-webkit-transform-origin:top left;transform-origin:top left}.phylocanvas-history-snapshots{position:absolute;top:0;bottom:0;left:0;right:0;margin:0;padding:0;overflow-x:hidden;overflow-y:scroll}.phylocanvas-history-snapshot{list-style:none;border-bottom:1px solid #e7e7e7;cursor:pointer;box-sizing:border-box;display:block;position:relative;height:128px}.phylocanvas-history-snapshot:after{content:"";position:absolute;top:0;bottom:0;right:0;width:4px;background-color:transparent;-webkit-transition:background-color .2s cubic-bezier(.4,0,.2,1);transition:background-color .2s cubic-bezier(.4,0,.2,1)}.phylocanvas-history-snapshot--selected:after,.phylocanvas-history-snapshot:hover:after{background-color:#3c7383}.phylocanvas-history-snapshot>img{width:100%;height:128px;-o-object-fit:contain;object-fit:contain}', ""])
            }, function(t, e) {
                t.exports = function() {
                    var t = [];
                    return t.toString = function() {
                        for (var t = [], e = 0; e < this.length; e++) {
                            var n = this[e];
                            n[2] ? t.push("@media " + n[2] + "{" + n[1] + "}") : t.push(n[1])
                        }
                        return t.join("")
                    }, t.i = function(e, n) {
                        "string" == typeof e && (e = [
                            [null, e, ""]
                        ]);
                        for (var r = {}, a = 0; a < this.length; a++) {
                            var i = this[a][0];
                            "number" == typeof i && (r[i] = !0)
                        }
                        for (a = 0; a < e.length; a++) {
                            var o = e[a];
                            "number" == typeof o[0] && r[o[0]] || (n && !o[2] ? o[2] = n : n && (o[2] = "(" + o[2] + ") and (" + n + ")"), t.push(o))
                        }
                    }, t
                }
            }, function(t, e, n) {
                function r(t, e) {
                    for (var n = 0; n < t.length; n++) {
                        var r = t[n],
                            a = d[r.id];
                        if (a) {
                            a.refs++;
                            for (var i = 0; i < a.parts.length; i++) a.parts[i](r.parts[i]);
                            for (; i < r.parts.length; i++) a.parts.push(c(r.parts[i], e))
                        } else {
                            for (var o = [], i = 0; i < r.parts.length; i++) o.push(c(r.parts[i], e));
                            d[r.id] = {
                                id: r.id,
                                refs: 1,
                                parts: o
                            }
                        }
                    }
                }

                function a(t) {
                    for (var e = [], n = {}, r = 0; r < t.length; r++) {
                        var a = t[r],
                            i = a[0],
                            o = a[1],
                            s = a[2],
                            l = a[3],
                            c = {
                                css: o,
                                media: s,
                                sourceMap: l
                            };
                        n[i] ? n[i].parts.push(c) : e.push(n[i] = {
                            id: i,
                            parts: [c]
                        })
                    }
                    return e
                }

                function i(t, e) {
                    var n = p(),
                        r = b[b.length - 1];
                    if ("top" === t.insertAt) r ? r.nextSibling ? n.insertBefore(e, r.nextSibling) : n.appendChild(e) : n.insertBefore(e, n.firstChild), b.push(e);
                    else {
                        if ("bottom" !== t.insertAt) throw new Error("Invalid value for parameter 'insertAt'. Must be 'top' or 'bottom'.");
                        n.appendChild(e)
                    }
                }

                function o(t) {
                    t.parentNode.removeChild(t);
                    var e = b.indexOf(t);
                    e >= 0 && b.splice(e, 1)
                }

                function s(t) {
                    var e = document.createElement("style");
                    return e.type = "text/css", i(t, e), e
                }

                function l(t) {
                    var e = document.createElement("link");
                    return e.rel = "stylesheet", i(t, e), e
                }

                function c(t, e) {
                    var n, r, a;
                    if (e.singleton) {
                        var i = y++;
                        n = g || (g = s(e)), r = h.bind(null, n, i, !1), a = h.bind(null, n, i, !0)
                    } else t.sourceMap && "function" == typeof URL && "function" == typeof URL.createObjectURL && "function" == typeof URL.revokeObjectURL && "function" == typeof Blob && "function" == typeof btoa ? (n = l(e), r = f.bind(null, n), a = function() {
                        o(n), n.href && URL.revokeObjectURL(n.href)
                    }) : (n = s(e), r = u.bind(null, n), a = function() {
                        o(n)
                    });
                    return r(t),
                        function(e) {
                            if (e) {
                                if (e.css === t.css && e.media === t.media && e.sourceMap === t.sourceMap) return;
                                r(t = e)
                            } else a()
                        }
                }

                function h(t, e, n, r) {
                    var a = n ? "" : r.css;
                    if (t.styleSheet) t.styleSheet.cssText = m(e, a);
                    else {
                        var i = document.createTextNode(a),
                            o = t.childNodes;
                        o[e] && t.removeChild(o[e]), o.length ? t.insertBefore(i, o[e]) : t.appendChild(i)
                    }
                }

                function u(t, e) {
                    var n = e.css,
                        r = e.media;
                    if (r && t.setAttribute("media", r), t.styleSheet) t.styleSheet.cssText = n;
                    else {
                        for (; t.firstChild;) t.removeChild(t.firstChild);
                        t.appendChild(document.createTextNode(n))
                    }
                }

                function f(t, e) {
                    var n = e.css,
                        r = e.sourceMap;
                    r && (n += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(r)))) + " */");
                    var a = new Blob([n], {
                            type: "text/css"
                        }),
                        i = t.href;
                    t.href = URL.createObjectURL(a), i && URL.revokeObjectURL(i)
                }
                var d = {},
                    C = function(t) {
                        var e;
                        return function() {
                            return "undefined" == typeof e && (e = t.apply(this, arguments)), e
                        }
                    },
                    v = C(function() {
                        return /msie [6-9]\b/.test(window.navigator.userAgent.toLowerCase())
                    }),
                    p = C(function() {
                        return document.head || document.getElementsByTagName("head")[0]
                    }),
                    g = null,
                    y = 0,
                    b = [];
                t.exports = function(t, e) {
                    e = e || {}, "undefined" == typeof e.singleton && (e.singleton = v()), "undefined" == typeof e.insertAt && (e.insertAt = "bottom");
                    var n = a(t);
                    return r(n, e),
                        function(t) {
                            for (var i = [], o = 0; o < n.length; o++) {
                                var s = n[o],
                                    l = d[s.id];
                                l.refs--, i.push(l)
                            }
                            if (t) {
                                var c = a(t);
                                r(c, e)
                            }
                            for (var o = 0; o < i.length; o++) {
                                var l = i[o];
                                if (0 === l.refs) {
                                    for (var h = 0; h < l.parts.length; h++) l.parts[h]();
                                    delete d[l.id]
                                }
                            }
                        }
                };
                var m = function() {
                    var t = [];
                    return function(e, n) {
                        return t[e] = n, t.filter(Boolean).join("\n")
                    }
                }()
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    if (Array.isArray(t)) {
                        for (var e = 0, n = Array(t.length); e < t.length; e++) n[e] = t[e];
                        return n
                    }
                    return Array.from(t)
                }

                function a(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }

                function i(t) {
                    t(this, "createTree", function(t, e) {
                        var n = t.apply(void 0, r(e)),
                            a = o(e, 2),
                            i = a[1],
                            s = void 0 === i ? {} : i;
                        return s.history !== !1 && (n.history = new y(n, s.history || {})), n
                    }), this.History = y
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var o = function() {
                        function t(t, e) {
                            var n = [],
                                r = !0,
                                a = !1,
                                i = void 0;
                            try {
                                for (var o, s = t[Symbol.iterator](); !(r = (o = s.next()).done) && (n.push(o.value), !e || n.length !== e); r = !0);
                            } catch (t) {
                                a = !0, i = t
                            } finally {
                                try {
                                    !r && s.return && s.return()
                                } finally {
                                    if (a) throw i
                                }
                            }
                            return n
                        }
                        return function(e, n) {
                            if (Array.isArray(e)) return e;
                            if (Symbol.iterator in Object(e)) return t(e, n);
                            throw new TypeError("Invalid attempt to destructure non-iterable instance")
                        }
                    }(),
                    s = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }();
                e.default = i;
                var l = n(6),
                    c = l.utils.dom,
                    h = c.addClass,
                    u = c.removeClass,
                    f = l.utils.events,
                    d = f.fireEvent,
                    C = f.addEvent,
                    v = f.killEvent,
                    p = "phylocanvas-history-snapshot",
                    g = p + "--selected",
                    y = function() {
                        function t(e, n) {
                            var r = this,
                                i = n.parent,
                                o = void 0 === i ? e.containerElement : i,
                                s = n.zIndex,
                                l = void 0 === s ? 1 : s;
                            a(this, t), this.tree = e, this.snapshots = [], this.isOpen = !1, this.parent = o, this.buttonClickHandler = this.toggle.bind(this), this.container = this.createElements(o), this.container.style.zIndex = l, this.tree.addListener("subtree", function(t) {
                                var e = t.node;
                                return r.addSnapshot(e)
                            }), this.tree.addListener("loaded", function() {
                                return r.addSnapshot(r.tree.root.id)
                            }), this.tree.addListener("typechanged", function() {
                                return r.addSnapshot(r.tree.root.id)
                            })
                        }
                        return s(t, [{
                            key: "toggle",
                            value: function() {
                                this.isOpen = !this.isOpen, (this.isOpen ? h : u)(this.container, "phylocanvas-history--open"), this.parent[(this.isOpen ? "add" : "remove") + "EventListener"]("click", this.buttonClickHandler), d(this.tree.containerElement, "historytoggle", {
                                    isOpen: this.isOpen
                                })
                            }
                        }, {
                            key: "createElements",
                            value: function(t) {
                                var e = document.createElement("div");
                                e.className = "phylocanvas-history", C(e, "click", v), C(e, "contextmenu", v);
                                var n = document.createElement("button");
                                n.className = "phylocanvas-history-button", n.innerHTML = "History", C(n, "click", this.buttonClickHandler), e.appendChild(n), this.button = n;
                                var r = document.createElement("ul");
                                return r.className = "phylocanvas-history-snapshots", e.appendChild(r), this.snapshotList = r, t.appendChild(e), e
                            }
                        }, {
                            key: "addSnapshot",
                            value: function(t) {
                                if (t) {
                                    var e = this.tree.treeType,
                                        n = !1;
                                    if (this.snapshots.forEach(function(r) {
                                            u(r, g), r.getAttribute("data-tree-root") === t && r.getAttribute("data-tree-type") === e && (n = !0, h(r, g))
                                        }), !n) {
                                        var r = this.tree.getPngUrl(),
                                            a = document.createElement("li");
                                        a.className = p + " " + g, a.setAttribute("data-tree-root", t), a.setAttribute("data-tree-type", this.tree.treeType), a.className = p + " " + g;
                                        var i = document.createElement("img");
                                        i.src = r, this.snapshots.push(a), a.appendChild(i), this.snapshotList.appendChild(a), C(a, "click", this.goBackTo.bind(this, a))
                                    }
                                }
                            }
                        }, {
                            key: "clear",
                            value: function() {
                                for (var t = this.snapshots.length; t--;) this.snapshotList.removeChild(this.snapshots[t]);
                                this.snapshots.length = 0
                            }
                        }, {
                            key: "goBackTo",
                            value: function(t) {
                                var e = t.getAttribute("data-tree-root");
                                this.tree.setTreeType(t.getAttribute("data-tree-type"), !0), this.tree.redrawFromBranch(this.tree.originalTree.branches[e]), this.toggle()
                            }
                        }]), t
                    }()
            }, function(e, n) {
                e.exports = t
            }])
        })
    }, function(t, e, n) {
        ! function(e, n) {
            t.exports = n()
        }(this, function() {
            return function(t) {
                function e(r) {
                    if (n[r]) return n[r].exports;
                    var a = n[r] = {
                        exports: {},
                        id: r,
                        loaded: !1
                    };
                    return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
                }
                var n = {};
                return e.m = t, e.c = n, e.p = "/dist/", e(0)
            }([function(t, e, n) {
                "use strict";

                function r(t) {
                    if (t && t.__esModule) return t;
                    var e = {};
                    if (null != t)
                        for (var n in t) Object.prototype.hasOwnProperty.call(t, n) && (e[n] = t[n]);
                    return e.default = t, e
                }

                function a(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }

                function i(t, e, n) {
                    var r = t[e] ? t : t.prototype,
                        a = r[e];
                    r[e] = function() {
                        for (var t = arguments.length, e = Array(t), r = 0; r < t; r++) e[r] = arguments[r];
                        return n.call(this, a, e)
                    }
                }

                function o(t) {
                    t.call(this, i)
                }

                function s(t) {
                    var e = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {};
                    return new c.default(t, e)
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.utils = e.nodeRenderers = e.treeTypes = e.Parser = e.Tooltip = e.Prerenderer = e.Branch = e.Tree = void 0;
                var l = n(1),
                    c = a(l),
                    h = n(7),
                    u = a(h),
                    f = n(11),
                    d = a(f),
                    C = n(27),
                    v = a(C),
                    p = n(29),
                    g = a(p),
                    y = n(8),
                    b = a(y),
                    m = n(26),
                    x = a(m),
                    w = n(2),
                    S = r(w);
                e.Tree = c.default, e.Branch = u.default, e.Prerenderer = d.default, e.Tooltip = v.default, e.Parser = g.default, e.treeTypes = b.default, e.nodeRenderers = x.default, e.utils = S, e.default = {
                    plugin: o,
                    createTree: s
                }
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }

                function a(t) {
                    if (Array.isArray(t)) {
                        for (var e = 0, n = Array(t.length); e < t.length; e++) n[e] = t[e];
                        return n
                    }
                    return Array.from(t)
                }

                function i(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var o = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }(),
                    s = n(2),
                    l = n(7),
                    c = r(l),
                    h = n(27),
                    u = n(8),
                    f = r(u),
                    d = n(28),
                    C = r(d),
                    v = s.dom.addClass,
                    p = s.dom.setCursorDrag,
                    g = s.dom.setCursorDragging,
                    y = s.events.fireEvent,
                    b = s.events.addEvent,
                    m = s.events.removeEvent,
                    x = s.canvas.getPixelRatio,
                    w = s.canvas.translateClick,
                    S = s.constants.Predicates,
                    k = function() {
                        function t(e) {
                            var n = this,
                                r = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {};
                            i(this, t), this._point = {
                                x: 0,
                                y: 0
                            }, this.containerElement = "string" == typeof e ? document.getElementById(e) : e, v(this.containerElement, "pc-container"), this.branches = {}, this.leaves = [], this.root = !1, this.stringRepresentation = "", this.backColour = !1, this.originalTree = {}, "static" === window.getComputedStyle(this.containerElement).position && (this.containerElement.style.position = "relative"), this.containerElement.style.boxSizing = "border-box";
                            var a = document.createElement("canvas");
                            a.id = (this.containerElement.id || "") + "__canvas", a.className = "phylocanvas", a.style.position = "relative", a.height = e.offsetHeight || 400, a.width = e.offsetWidth || 400, a.style.zIndex = "1", this.containerElement.appendChild(a), this.canvas = a.getContext("2d"), this.canvas.canvas.onselectstart = function() {
                                return !1
                            }, this.canvas.fillStyle = "#000000", this.canvas.strokeStyle = "#000000", this.canvas.save(), this.collapsedColour = "rgba(0, 0, 0, 0.5)", this.defaultCollapsed = {}, this.tooltip = new h.ChildNodesTooltip(this), this.drawn = !1, this.highlighters = [], this.zoom = 1, this.zoomFactor = 3, this.disableZoom = !1, this.fillCanvas = !1, this.branchScaling = !0, this.currentBranchScale = 1, this.branchScalingStep = 1.2, this.pickedup = !1, this.dragging = !1, this.startx = null, this.starty = null, this.baseNodeSize = 1, this.origx = null, this.origy = null, this.offsetx = this.canvas.canvas.width / 2, this.offsety = this.canvas.canvas.height / 2, this.selectedColour = "rgba(49,151,245,1)", this.highlightColour = "rgba(49,151,245,1)", this.highlightWidth = 4, this.highlightSize = 2, this.branchColour = "rgba(0,0,0,1)", this.branchScalar = 1, this.padding = 50, this.labelPadding = 5, this.multiSelect = !0, this.clickFlag = "selected", this.clickFlagPredicate = S.tautology, this.hoverLabel = !1, this.internalNodesSelectable = !0, this.showLabels = !0, this.showBranchLengthLabels = !1, this.branchLengthLabelPredicate = S.tautology, this.showInternalNodeLabels = !1, this.internalLabelStyle = {
                                colour: this.branchColour,
                                textSize: this.textSize,
                                font: this.font,
                                format: ""
                            }, this.setTreeType("radial"), this.maxBranchLength = 0, this.lineWidth = 1, this.textSize = 7, this.font = "sans-serif", this.unselectOnClickAway = !0, this.farthestNodeFromRootX = 0, this.farthestNodeFromRootY = 0, this.shiftKeyDrag = !1, this.maxLabelLength = {}, Object.assign(this, r), this.resizeToContainer(), this.eventListeners = {};
                            var o = Object.assign({
                                    click: {
                                        listener: this.clicked.bind(this)
                                    },
                                    mousedown: {
                                        listener: this.pickup.bind(this)
                                    },
                                    mouseup: {
                                        listener: this.drop.bind(this)
                                    },
                                    mouseout: {
                                        listener: this.drop.bind(this)
                                    },
                                    mousemove: {
                                        target: this.canvas.canvas,
                                        listener: this.drag.bind(this)
                                    },
                                    mousewheel: {
                                        target: this.canvas.canvas,
                                        listener: this.scroll.bind(this)
                                    },
                                    DOMMouseScroll: {
                                        target: this.canvas.canvas,
                                        listener: this.scroll.bind(this)
                                    },
                                    resize: {
                                        target: window,
                                        listener: function() {
                                            n.resizeToContainer(), n.draw()
                                        }
                                    }
                                }, r.eventListeners || {}),
                                s = !0,
                                l = !1,
                                c = void 0;
                            try {
                                for (var u, f = Object.keys(o)[Symbol.iterator](); !(s = (u = f.next()).done); s = !0) {
                                    var d = u.value,
                                        C = o[d],
                                        p = C.listener,
                                        g = C.target;
                                    this.addListener(d, p, g)
                                }
                            } catch (t) {
                                l = !0, c = t
                            } finally {
                                try {
                                    !s && f.return && f.return()
                                } finally {
                                    if (l) throw c
                                }
                            }
                        }
                        return o(t, [{
                            key: "removeEventListeners",
                            value: function() {
                                var t = !0,
                                    e = !1,
                                    n = void 0;
                                try {
                                    for (var r, a = Object.keys(this.eventListeners)[Symbol.iterator](); !(t = (r = a.next()).done); t = !0) {
                                        var i = r.value,
                                            o = !0,
                                            s = !1,
                                            l = void 0;
                                        try {
                                            for (var c, h = this.eventListeners[i][Symbol.iterator](); !(o = (c = h.next()).done); o = !0) {
                                                var u = c.value,
                                                    f = u.target,
                                                    d = u.listener;
                                                m(f || this.containerElement, i, d)
                                            }
                                        } catch (t) {
                                            s = !0, l = t
                                        } finally {
                                            try {
                                                !o && h.return && h.return()
                                            } finally {
                                                if (s) throw l
                                            }
                                        }
                                    }
                                } catch (t) {
                                    e = !0, n = t
                                } finally {
                                    try {
                                        !t && a.return && a.return()
                                    } finally {
                                        if (e) throw n
                                    }
                                }
                            }
                        }, {
                            key: "setInitialCollapsedBranches",
                            value: function() {
                                var t, e, n = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : this.root;
                                if (t = n.getChildProperties("id"), t && t.length > this.defaultCollapsed.min && t.length < this.defaultCollapsed.max) return void(n.collapsed = !0);
                                for (e = 0; e < n.children.length; e++) this.setInitialCollapsedBranches(n.children[e])
                            }
                        }, {
                            key: "getNodeAtMousePosition",
                            value: function(t) {
                                var e;
                                return (e = this.root).clicked.apply(e, a(w(t, this)))
                            }
                        }, {
                            key: "getSelectedNodeIds",
                            value: function() {
                                return this.getNodeIdsWithFlag("selected")
                            }
                        }, {
                            key: "getNodeIdsWithFlag",
                            value: function(t) {
                                var e = !(arguments.length > 1 && void 0 !== arguments[1]) || arguments[1];
                                return this.leaves.reduce(function(n, r) {
                                    return r[t] === e && n.push(r.id), n
                                }, [])
                            }
                        }, {
                            key: "clicked",
                            value: function(t) {
                                var e;
                                if (0 === t.button) {
                                    var n = [];
                                    if (this.dragging) return void(this.dragging = !1);
                                    if (!this.root) return !1;
                                    e = this.getNodeAtMousePosition(t);
                                    var r = this.multiSelect && (t.metaKey || t.ctrlKey);
                                    if (e && e.interactive)
                                        if (r) {
                                            if (e.leaf) e[this.clickFlag] = !e[this.clickFlag];
                                            else if (this.internalNodesSelectable) {
                                                var a = e.getChildProperties(this.clickFlag).some(function(t) {
                                                    return t === !1
                                                });
                                                e.cascadeFlag(this.clickFlag, a, this.clickFlagPredicate)
                                            }
                                            n = this.getNodeIdsWithFlag(this.clickFlag), this.draw()
                                        } else this.root.cascadeFlag(this.clickFlag, !1, this.clickFlagPredicate), (this.internalNodesSelectable || e.leaf) && (e.cascadeFlag(this.clickFlag, !0, this.clickFlagPredicate), n = e.getChildProperties("id")), this.draw();
                                    else !this.unselectOnClickAway || this.dragging || r || (this.root.cascadeFlag(this.clickFlag, !1, this.clickFlagPredicate), this.draw());
                                    this.pickedup || (this.dragging = !1), this.nodesUpdated(n, this.clickFlag)
                                }
                            }
                        }, {
                            key: "drag",
                            value: function(t) {
                                var e = x(this.canvas);
                                if (!this.drawn) return !1;
                                if (this.pickedup) {
                                    var n = (t.clientX - this.startx) * e,
                                        r = (t.clientY - this.starty) * e;
                                    Math.abs(n) + Math.abs(r) > 5 && (this.dragging = !0, this.offsetx = this.origx + n, this.offsety = this.origy + r, this.draw())
                                } else {
                                    var a = t,
                                        i = this.getNodeAtMousePosition(a);
                                    i && i.interactive && (this.internalNodesSelectable || i.leaf) ? (this.root.cascadeFlag("hovered", !1), i.hovered = !0, i.leaf || i.hasCollapsedAncestor() || this.tooltip.open(a.clientX, a.clientY, i), this.containerElement.style.cursor = "pointer") : (this.tooltip.close(), this.root.cascadeFlag("hovered", !1), this.shiftKeyDrag && a.shiftKey ? p(this.containerElement) : this.containerElement.style.cursor = "auto"), this.draw()
                                }
                            }
                        }, {
                            key: "draw",
                            value: function(t) {
                                if (this.highlighters.length = 0, 0 === this.maxBranchLength) return void this.loadError(new Error("All branches in the tree are identical."));
                                this.canvas.clearRect(0, 0, this.canvas.canvas.width, this.canvas.canvas.height), this.canvas.lineCap = "round", this.canvas.lineJoin = "round", this.canvas.strokeStyle = this.branchColour, this.canvas.save(), this.drawn && !t || (this.prerenderer.run(this), t || this.fitInPanel());
                                var e = x(this.canvas);
                                this.canvas.lineWidth = this.lineWidth / this.zoom, this.canvas.translate(this.offsetx * e, this.offsety * e), this.canvas.scale(this.zoom, this.zoom), this.branchRenderer.render(this, this.root), this.highlighters.forEach(function(t) {
                                    return t()
                                }), this.drawn = !0, this.canvas.restore()
                            }
                        }, {
                            key: "pickup",
                            value: function(t) {
                                if (!this.shiftKeyDrag || t.shiftKey) {
                                    if (!this.drawn) return !1;
                                    this.origx = this.offsetx, this.origy = this.offsety, 0 === t.button && (this.pickedup = !0, g(this.containerElement)), this.startx = t.clientX, this.starty = t.clientY
                                }
                            }
                        }, {
                            key: "drop",
                            value: function(t) {
                                return !!this.drawn && (this.pickedup = !1, void(this.shiftKeyDrag && t.shiftKey ? p(this.containerElement) : this.containerElement.style.cursor = "auto"))
                            }
                        }, {
                            key: "scroll",
                            value: function(t) {
                                if (!(this.disableZoom || "wheelDelta" in t && 0 === t.wheelDelta)) {
                                    t.preventDefault(), this._point.x = t.offsetX, this._point.y = t.offsetY;
                                    var e = t.detail < 0 || t.wheelDelta > 0 ? 1 : -1;
                                    this.branchScaling && (t.metaKey || t.ctrlKey) ? (this.currentBranchScale *= Math.pow(this.branchScalingStep, e), this.setBranchScale(this.currentBranchScale, this._point)) : this.smoothZoom(e, this._point)
                                }
                            }
                        }, {
                            key: "findLeaves",
                            value: function(t) {
                                var e = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : "id",
                                    n = [],
                                    r = !0,
                                    a = !1,
                                    i = void 0;
                                try {
                                    for (var o, s = this.leaves[Symbol.iterator](); !(r = (o = s.next()).done); r = !0) {
                                        var l = o.value;
                                        l[e] && l[e].match(t) && n.push(l)
                                    }
                                } catch (t) {
                                    a = !0, i = t
                                } finally {
                                    try {
                                        !r && s.return && s.return()
                                    } finally {
                                        if (a) throw i
                                    }
                                }
                                return n
                            }
                        }, {
                            key: "updateLeaves",
                            value: function(t, e, n) {
                                var r = !0,
                                    a = !1,
                                    i = void 0;
                                try {
                                    for (var o, s = this.leaves[Symbol.iterator](); !(r = (o = s.next()).done); r = !0) {
                                        var l = o.value;
                                        l[e] = !n
                                    }
                                } catch (t) {
                                    a = !0, i = t
                                } finally {
                                    try {
                                        !r && s.return && s.return()
                                    } finally {
                                        if (a) throw i
                                    }
                                }
                                var c = !0,
                                    h = !1,
                                    u = void 0;
                                try {
                                    for (var f, d = t[Symbol.iterator](); !(c = (f = d.next()).done); c = !0) {
                                        var C = f.value;
                                        C[e] = n
                                    }
                                } catch (t) {
                                    h = !0, u = t
                                } finally {
                                    try {
                                        !c && d.return && d.return()
                                    } finally {
                                        if (h) throw u
                                    }
                                }
                                this.nodesUpdated(t.map(function(t) {
                                    return t.id
                                }), e)
                            }
                        }, {
                            key: "clearSelect",
                            value: function() {
                                this.root.cascadeFlag("selected", !1), this.draw()
                            }
                        }, {
                            key: "getPngUrl",
                            value: function() {
                                return this.canvas.canvas.toDataURL()
                            }
                        }, {
                            key: "load",
                            value: function(t) {
                                var e = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {},
                                    n = arguments[2],
                                    r = e,
                                    a = n;
                                if ("function" == typeof e && (a = e, r = {}), a && (r.callback = a), r.format) return void this.build(t, C.default[r.format], r);
                                var i = !0,
                                    o = !1,
                                    s = void 0;
                                try {
                                    for (var l, c = Object.keys(C.default)[Symbol.iterator](); !(i = (l = c.next()).done); i = !0) {
                                        var h = l.value,
                                            u = C.default[h];
                                        if (t.match(u.fileExtension) || t.match(u.validator)) return void this.build(t, u, r)
                                    }
                                } catch (t) {
                                    o = !0, s = t
                                } finally {
                                    try {
                                        !i && c.return && c.return()
                                    } finally {
                                        if (o) throw s
                                    }
                                }
                                var f = new Error("String not recognised as a file or a parseable format string");
                                a && a(f), this.loadError(f)
                            }
                        }, {
                            key: "saveOriginalTree",
                            value: function() {
                                this.originalTree.branches = this.branches, this.originalTree.leaves = this.leaves, this.originalTree.root = this.root, this.originalTree.branchLengths = {}, this.originalTree.parents = {}
                            }
                        }, {
                            key: "clearState",
                            value: function() {
                                this.root = !1, this.leaves = [], this.branches = {}, this.drawn = !1
                            }
                        }, {
                            key: "extractNestedBranches",
                            value: function() {
                                this.branches = {}, this.leaves = [], this.storeNode(this.root), this.root.extractChildren()
                            }
                        }, {
                            key: "saveState",
                            value: function() {
                                if (this.extractNestedBranches(), this.root.branchLength = 0, this.maxBranchLength = 0, this.root.setTotalLength(), 0 === this.maxBranchLength) return void this.loadError(new Error("All branches in the tree are identical."))
                            }
                        }, {
                            key: "build",
                            value: function(t, e, n) {
                                var r = this;
                                this.originalTree = {}, this.clearState(), c.default.lastId = 0;
                                var a = new c.default;
                                a.id = "root", this.branches.root = a, this.setRoot(a), e.parse({
                                    formatString: t,
                                    root: a,
                                    options: n
                                }, function(e) {
                                    return e ? (n.callback && n.callback(e), void r.loadError(e)) : (r.stringRepresentation = t, r.saveState(), r.setInitialCollapsedBranches(), r.beforeFirstDraw(), r.draw(), r.saveOriginalTree(), n.callback && n.callback(), void r.loadCompleted())
                                })
                            }
                        }, {
                            key: "redrawFromBranch",
                            value: function(t) {
                                this.clearState(), this.resetTree(), this.originalTree.branchLengths[t.id] = t.branchLength, this.originalTree.parents[t.id] = t.parent, this.root = t, this.root.parent = !1, this.saveState(), this.draw(), this.subtreeDrawn(t.id)
                            }
                        }, {
                            key: "redrawOriginalTree",
                            value: function() {
                                this.load(this.stringRepresentation)
                            }
                        }, {
                            key: "storeNode",
                            value: function(t) {
                                if (t.id && "" !== t.id || (t.id = c.default.generateId()), this.branches[t.id] && t !== this.branches[t.id]) {
                                    if (t.leaf) throw new Error("Two nodes on this tree share the id " + t.id);
                                    t.id = c.default.generateId()
                                }
                                this.branches[t.id] = t, t.leaf && this.leaves.push(t)
                            }
                        }, {
                            key: "setNodeSize",
                            value: function(t) {
                                this.baseNodeSize = Number(t), this.draw()
                            }
                        }, {
                            key: "setRoot",
                            value: function(t) {
                                t.tree = this, this.root = t
                            }
                        }, {
                            key: "setTextSize",
                            value: function(t) {
                                this.textSize = Number(t), this.draw()
                            }
                        }, {
                            key: "setFontSize",
                            value: function(t) {
                                this.textSize = this.calculateFontSize ? this.calculateFontSize(t) : Math.min(t / 2, 15), this.canvas.font = this.textSize + "pt " + this.font
                            }
                        }, {
                            key: "setTreeType",
                            value: function(t, e) {
                                if (!(t in f.default)) return y(this.containerElement, "error", {
                                    error: new Error('"' + t + '" is not a known tree-type.')
                                });
                                var n = this.treeType;
                                this.treeType = t, this.type = f.default[t], this.branchRenderer = f.default[t].branchRenderer, this.prerenderer = f.default[t].prerenderer, this.labelAlign = f.default[t].labelAlign, this.calculateFontSize = f.default[t].calculateFontSize, this.drawn && (this.drawn = !1, this.draw()), e || this.treeTypeChanged(n, t)
                            }
                        }, {
                            key: "setSize",
                            value: function(t, e) {
                                this.canvas.canvas.width = t, this.canvas.canvas.height = e, this.navigator && this.navigator.resize(), this.adjustForPixelRatio()
                            }
                        }, {
                            key: "adjustForPixelRatio",
                            value: function() {
                                var t = x(this.canvas);
                                this.canvas.canvas.style.height = this.canvas.canvas.height + "px", this.canvas.canvas.style.width = this.canvas.canvas.width + "px", t > 1 && (this.canvas.canvas.width *= t, this.canvas.canvas.height *= t)
                            }
                        }, {
                            key: "getCentrePoint",
                            value: function() {
                                var t = x(this.canvas);
                                return {
                                    x: this.canvas.canvas.width / 2 / t,
                                    y: this.canvas.canvas.height / 2 / t
                                }
                            }
                        }, {
                            key: "setZoom",
                            value: function(t) {
                                var e = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : this.getCentrePoint(),
                                    n = e.x,
                                    r = e.y;
                                if (t > 0) {
                                    var a = this.zoom;
                                    this.zoom = t, this.offsetx = this.calculateZoomedOffset(this.offsetx, n, a, t), this.offsety = this.calculateZoomedOffset(this.offsety, r, a, t), this.draw()
                                }
                            }
                        }, {
                            key: "smoothZoom",
                            value: function(t, e) {
                                this.setZoom(Math.pow(10, Math.log(this.zoom) / Math.log(10) + t * this.zoomFactor * .01), e)
                            }
                        }, {
                            key: "calculateZoomedOffset",
                            value: function(t, e, n, r) {
                                return -1 * ((-1 * t + e) / n * r - e)
                            }
                        }, {
                            key: "setBranchScale",
                            value: function() {
                                var t = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : 1,
                                    e = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {
                                        x: this.canvas.canvas.width / 2,
                                        y: this.canvas.canvas.height / 2
                                    },
                                    n = f.default[this.treeType];
                                if (n.branchScalingAxis && !(t < 0)) {
                                    var r = this.branchScalar;
                                    this.branchScalar = this.initialBranchScalar * t;
                                    var a = this.branchScalar / r,
                                        i = this["offset" + n.branchScalingAxis],
                                        o = e[n.branchScalingAxis],
                                        s = (e[n.branchScalingAxis] - i) * a + i;
                                    this["offset" + n.branchScalingAxis] += o - s, this.draw()
                                }
                            }
                        }, {
                            key: "toggleLabels",
                            value: function() {
                                this.showLabels = !this.showLabels, this.draw()
                            }
                        }, {
                            key: "setMaxLabelLength",
                            value: function() {
                                var t;
                                void 0 === this.maxLabelLength[this.treeType] && (this.maxLabelLength[this.treeType] = 0);
                                for (var e = 0; e < this.leaves.length; e++) t = this.canvas.measureText(this.leaves[e].id), t.width > this.maxLabelLength[this.treeType] && (this.maxLabelLength[this.treeType] = t.width)
                            }
                        }, {
                            key: "loadStarted",
                            value: function() {
                                y(this.containerElement, "loading")
                            }
                        }, {
                            key: "beforeFirstDraw",
                            value: function() {
                                y(this.containerElement, "beforeFirstDraw")
                            }
                        }, {
                            key: "loadCompleted",
                            value: function() {
                                y(this.containerElement, "loaded")
                            }
                        }, {
                            key: "loadError",
                            value: function(t) {
                                y(this.containerElement, "error", {
                                    error: t
                                })
                            }
                        }, {
                            key: "subtreeDrawn",
                            value: function(t) {
                                y(this.containerElement, "subtree", {
                                    node: t
                                })
                            }
                        }, {
                            key: "nodesUpdated",
                            value: function(t, e) {
                                var n = arguments.length > 2 && void 0 !== arguments[2] && arguments[2];
                                y(this.containerElement, "updated", {
                                    nodeIds: t,
                                    property: e,
                                    append: n
                                })
                            }
                        }, {
                            key: "treeTypeChanged",
                            value: function(t, e) {
                                y(this.containerElement, "typechanged", {
                                    oldType: t,
                                    newType: e
                                })
                            }
                        }, {
                            key: "addListener",
                            value: function(t, e, n) {
                                this.eventListeners[t] || (this.eventListeners[t] = []), this.eventListeners[t].push({
                                    listener: e,
                                    target: n
                                }), b(n || this.containerElement, t, e)
                            }
                        }, {
                            key: "removeListener",
                            value: function(t, e, n) {
                                m(n || this.containerElement, t, e)
                            }
                        }, {
                            key: "getBounds",
                            value: function() {
                                var t = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : this.leaves,
                                    e = t === this.leaves ? this.root : t[0],
                                    n = e.startx,
                                    r = e.startx,
                                    a = e.starty,
                                    i = e.starty,
                                    o = !0,
                                    s = !1,
                                    l = void 0;
                                try {
                                    for (var c, h = t[Symbol.iterator](); !(o = (c = h.next()).done); o = !0) {
                                        var u = c.value,
                                            f = u.getBounds();
                                        n = Math.min(n, f.minx), r = Math.max(r, f.maxx), a = Math.min(a, f.miny), i = Math.max(i, f.maxy)
                                    }
                                } catch (t) {
                                    s = !0, l = t
                                } finally {
                                    try {
                                        !o && h.return && h.return()
                                    } finally {
                                        if (s) throw l
                                    }
                                }
                                return [
                                    [n, a],
                                    [r, i]
                                ]
                            }
                        }, {
                            key: "fitInPanel",
                            value: function(t) {
                                this.zoom = 1;
                                var e = this.getBounds(t),
                                    n = [this.canvas.canvas.width - 2 * this.padding, this.canvas.canvas.height - 2 * this.padding],
                                    r = [e[1][0] - e[0][0], e[1][1] - e[0][1]],
                                    a = x(this.canvas),
                                    i = n[0] / r[0],
                                    o = n[1] / r[1];
                                this.zoom = Math.min(i, o), this.offsetx = -1 * e[0][0] * this.zoom, this.offsety = -1 * e[0][1] * this.zoom, i > o ? (this.offsetx += this.padding + (n[0] - r[0] * this.zoom) / 2, this.offsety += this.padding) : (this.offsetx += this.padding, this.offsety += this.padding + (n[1] - r[1] * this.zoom) / 2), this.offsetx = this.offsetx / a, this.offsety = this.offsety / a
                            }
                        }, {
                            key: "resetTree",
                            value: function() {
                                if (this.originalTree.branches) {
                                    this.branches = this.originalTree.branches;
                                    var t = !0,
                                        e = !1,
                                        n = void 0;
                                    try {
                                        for (var r, a = Object.keys(this.originalTree.branchLengths)[Symbol.iterator](); !(t = (r = a.next()).done); t = !0) {
                                            var i = r.value;
                                            this.branches[i].branchLength = this.originalTree.branchLengths[i], this.branches[i].parent = this.originalTree.parents[i]
                                        }
                                    } catch (t) {
                                        e = !0, n = t
                                    } finally {
                                        try {
                                            !t && a.return && a.return()
                                        } finally {
                                            if (e) throw n
                                        }
                                    }
                                    this.leaves = this.originalTree.leaves, this.root = this.originalTree.root
                                }
                            }
                        }, {
                            key: "rotateBranch",
                            value: function(t) {
                                this.branches[t.id].rotate()
                            }
                        }, {
                            key: "exportNwk",
                            value: function() {
                                var t = this.root.getNwk();
                                return t.substr(0, t.lastIndexOf(")") + 1) + ";"
                            }
                        }, {
                            key: "resizeToContainer",
                            value: function() {
                                this.setSize(this.containerElement.offsetWidth, this.containerElement.offsetHeight)
                            }
                        }, {
                            key: "cleanup",
                            value: function() {
                                this.removeEventListeners()
                            }
                        }, {
                            key: "alignLabels",
                            get: function() {
                                return this.showLabels && this.labelAlign && this.labelAlignEnabled
                            },
                            set: function(t) {
                                this.labelAlignEnabled = t
                            }
                        }]), t
                    }();
                k.prototype.on = k.prototype.addListener, k.prototype.off = k.prototype.removeListener, e.default = k
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    if (t && t.__esModule) return t;
                    var e = {};
                    if (null != t)
                        for (var n in t) Object.prototype.hasOwnProperty.call(t, n) && (e[n] = t[n]);
                    return e.default = t, e
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.events = e.dom = e.constants = e.canvas = void 0;
                var a = n(3),
                    i = r(a),
                    o = n(6),
                    s = r(o),
                    l = n(4),
                    c = r(l),
                    h = n(5),
                    u = r(h);
                e.canvas = i, e.constants = s, e.dom = c, e.events = u
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t.backingStorePixelRatio || t.webkitBackingStorePixelRatio || t.mozBackingStorePixelRatio || t.msBackingStorePixelRatio || t.oBackingStorePixelRatio || 1
                }

                function a(t) {
                    return (window.devicePixelRatio || 1) / r(t)
                }

                function i(t, e) {
                    var n = a(e.canvas);
                    return [(t.offsetX - e.offsetx) / e.zoom * n, (t.offsetY - e.offsety) / e.zoom * n]
                }

                function o() {
                    var t = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : {
                            x: 0,
                            y: 0
                        },
                        e = t.x,
                        n = t.y,
                        r = arguments[1],
                        i = a(r.canvas);
                    return {
                        x: (e - r.offsetx) / r.zoom * i,
                        y: (n - r.offsety) / r.zoom * i
                    }
                }

                function s() {
                    var t = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : {
                            x: 0,
                            y: 0
                        },
                        e = t.x,
                        n = t.y,
                        r = arguments[1],
                        i = a(r.canvas);
                    return {
                        x: e / i * r.zoom + r.offsetx,
                        y: n / i * r.zoom + r.offsety
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.getBackingStorePixelRatio = r, e.getPixelRatio = a, e.translateClick = i, e.translatePoint = o, e.undoPointTranslation = s;
                n(4)
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    var e = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : "text/plain;charset=utf-8",
                        n = new Blob([t], {
                            type: e
                        });
                    return d.createObjectURL(n)
                }

                function a(t, e) {
                    var n = document.createElement("a"),
                        r = "undefined" != typeof n.download;
                    n.href = t, n.target = "_blank", r && (n.download = e), (0, f.fireEvent)(n, "click"), r && d.revokeObjectURL(n.href)
                }

                function i(t) {
                    for (var e = 0; t;) e += t.offsetLeft, t = t.offsetParent;
                    return e
                }

                function o(t) {
                    for (var e = 0; t;) e += t.offsetTop, t = t.offsetParent;
                    return e
                }

                function s(t, e) {
                    var n = t.className.split(" ");
                    n.indexOf(e) === -1 && (n.push(e), t.className = n.join(" "))
                }

                function l(t, e) {
                    var n = t.className.split(" "),
                        r = n.indexOf(e);
                    r !== -1 && (n.splice(r, 1), t.className = n.join(" "))
                }

                function c(t, e) {
                    var n = t.className.split(" "),
                        r = n.indexOf(e);
                    return r !== -1
                }

                function h(t) {
                    t.style.cursor = "-webkit-grabbing", t.style.cursor = "-moz-grabbing", t.style.cursor = "grabbing"
                }

                function u(t) {
                    t.style.cursor = "-webkit-grab", t.style.cursor = "-moz-grab", t.style.cursor = "grab"
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.createBlobUrl = r, e.setupDownloadLink = a, e.getX = i, e.getY = o, e.addClass = s, e.removeClass = l, e.hasClass = c, e.setCursorDragging = h, e.setCursorDrag = u;
                var f = n(5),
                    d = window.URL || window.webkitURL
            }, function(t, e) {
                "use strict";

                function n(t) {
                    return t.preventDefault(), !1
                }

                function r(t, e) {
                    var n, r, a = arguments.length > 2 && void 0 !== arguments[2] ? arguments[2] : {};
                    document.createEvent ? (n = document.createEvent("HTMLEvents"), n.initEvent(e, !0, !0)) : (n = document.createEventObject(), n.eventType = e), n.eventName = e;
                    for (r in a) a.hasOwnProperty(r) && (n[r] = a[r]);
                    document.createEvent ? t.dispatchEvent(n) : t.fireEvent("on" + n.eventType, n)
                }

                function a(t, e, n) {
                    t.addEventListener ? t.addEventListener(e, n, !1) : t.attachEvent("on" + e, function() {
                        return n.call(t, window.event)
                    })
                }

                function i(t, e, n) {
                    t.removeEventListener ? t.removeEventListener(e, n, !1) : console.warn("[Phylocanvas] Unable to remove event, removeEventListener not supported")
                }

                function o(t) {
                    t.stopPropagation(), t.preventDefault()
                }

                function s(t, e) {
                    var n;
                    return n = ("undefined" == typeof e ? "undefined" : l(e)) === l("aaa") ? function(n) {
                        if (t[e]) return t[e](n)
                    } : function() {
                        return e(t)
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var l = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function(t) {
                    return typeof t
                } : function(t) {
                    return t && "function" == typeof Symbol && t.constructor === Symbol && t !== Symbol.prototype ? "symbol" : typeof t
                };
                e.preventDefault = n, e.fireEvent = r, e.addEvent = a, e.removeEvent = i, e.killEvent = o, e.createHandler = s
            }, function(t, e) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                e.Angles = {
                    FORTYFIVE: Math.PI / 4,
                    QUARTER: Math.PI / 2,
                    HALF: Math.PI,
                    FULL: 2 * Math.PI
                }, e.Shapes = {
                    x: "star",
                    s: "square",
                    o: "circle",
                    t: "triangle"
                }, e.Predicates = {
                    tautology: function() {
                        return !0
                    },
                    contradiction: function() {
                        return !1
                    },
                    leafOnly: function(t) {
                        return t.leaf
                    },
                    nonLeaf: function(t) {
                        return !t.leaf
                    }
                }
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }

                function a(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var i = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }(),
                    o = n(2),
                    s = n(8),
                    l = r(s),
                    c = n(26),
                    h = r(c),
                    u = o.constants.Angles,
                    f = o.constants.Shapes,
                    d = {
                        minx: 0,
                        maxx: 0,
                        miny: 0,
                        maxy: 0
                    },
                    C = {
                        lineWidth: null,
                        strokeStyle: null,
                        fillStyle: null
                    },
                    v = function() {
                        function t() {
                            a(this, t), this.angle = 0, this.branchLength = 0, this.centerx = 0, this.centery = 0, this.children = [], this.collapsed = !1, this.colour = null, this.data = {}, this.highlighted = !1, this.hovered = !1, this.id = "", this.label = null, this.leaf = !0, this.maxChildAngle = 0, this.minChildAngle = u.FULL, this.nodeShape = "circle", this.parent = null, this.radius = 1, this.selected = !1, this.startx = 0, this.starty = 0, this.totalBranchLength = 0, this.tree = null, this.pruned = !1, this.labelStyle = {}, this.internalLabelStyle = null, this.interactive = !0, this.leafStyle = {}, this.minx = 0, this.miny = 0, this.maxx = 0, this.maxy = 0
                        }
                        return i(t, [{
                            key: "clicked",
                            value: function(t, e) {
                                if (this.dragging || this.hasCollapsedAncestor()) return null;
                                if (t < this.maxx && t > this.minx && e < this.maxy && e > this.miny) return this;
                                for (var n = this.children.length - 1; n >= 0; n--) {
                                    var r = this.children[n].clicked(t, e);
                                    if (r) return r
                                }
                            }
                        }, {
                            key: "drawLabel",
                            value: function() {
                                var t = this.getTextSize(),
                                    e = this.getLabel();
                                this.canvas.font = this.getFontString(), this.labelWidth = this.canvas.measureText(e).width, void 0 === this.tree.maxLabelLength[this.tree.treeType] && (this.tree.maxLabelLength[this.tree.treeType] = 0), this.labelWidth > this.tree.maxLabelLength[this.tree.treeType] && (this.tree.maxLabelLength[this.tree.treeType] = this.labelWidth);
                                var n = this.getLabelStartX();
                                this.tree.alignLabels && (n += Math.abs(this.tree.labelAlign.getLabelOffset(this))), this.angle > u.QUARTER && this.angle < u.HALF + u.QUARTER && (this.canvas.rotate(u.HALF), n = -n - 1 * this.labelWidth), this.canvas.beginPath(), this.canvas.fillStyle = this.getTextColour(), this.canvas.fillText(e, n, t / 2), this.canvas.closePath(), this.angle > u.QUARTER && this.angle < u.HALF + u.QUARTER && this.canvas.rotate(u.HALF)
                            }
                        }, {
                            key: "setNodeDimensions",
                            value: function(t, e, n) {
                                var r = n;
                                (n * this.tree.zoom < 5 || !this.leaf) && (r = 5 / this.tree.zoom), this.minx = t - r, this.maxx = t + r, this.miny = e - r, this.maxy = e + r
                            }
                        }, {
                            key: "getNumberOfLeaves",
                            value: function() {
                                for (var t = 0, e = [this]; e.length;) {
                                    var n = e.pop();
                                    if (n.leaf) t++;
                                    else {
                                        var r = !0,
                                            a = !1,
                                            i = void 0;
                                        try {
                                            for (var o, s = n.children[Symbol.iterator](); !(r = (o = s.next()).done); r = !0) {
                                                var l = o.value;
                                                e.push(l)
                                            }
                                        } catch (t) {
                                            a = !0, i = t
                                        } finally {
                                            try {
                                                !r && s.return && s.return()
                                            } finally {
                                                if (a) throw i
                                            }
                                        }
                                    }
                                }
                                return t
                            }
                        }, {
                            key: "drawCollapsed",
                            value: function(t, e) {
                                var n = l.default[this.tree.treeType].getCollapsedMeasurements;
                                this.canvas.beginPath();
                                var r = n(this),
                                    a = r.angle,
                                    i = r.radius,
                                    o = this.angle - a / 2,
                                    s = this.angle + a / 2;
                                this.canvas.moveTo(t, e), this.canvas.arc(t, e, i, o, s, !1);
                                var c = this.canvas.createRadialGradient(t, e, i, t, e, .2 * i);
                                c.addColorStop(0, "rgba(255, 255, 255, 0)"), c.addColorStop(1, this.tree.collapsedColour || this.getColour()), this.canvas.fillStyle = c, this.canvas.fill(), this.canvas.closePath()
                            }
                        }, {
                            key: "drawLabelConnector",
                            value: function() {
                                var t = this.tree,
                                    e = t.highlightColour,
                                    n = t.labelAlign;
                                this.canvas.save(), this.canvas.lineWidth = this.canvas.lineWidth / 4, this.canvas.strokeStyle = this.isHighlighted ? e : this.getColour(), this.canvas.beginPath(), this.canvas.moveTo(this.getRadius(), 0), this.canvas.lineTo(n.getLabelOffset(this) + this.getDiameter(), 0), this.canvas.stroke(), this.canvas.closePath(), this.canvas.restore()
                            }
                        }, {
                            key: "drawLeaf",
                            value: function() {
                                var t = this.tree,
                                    e = t.alignLabels,
                                    n = t.canvas;
                                e && this.drawLabelConnector(), n.save(), h.default[this.nodeShape](n, this.getRadius(), this.getLeafStyle()), n.restore(), (this.tree.showLabels || this.tree.hoverLabel && this.isHighlighted) && this.drawLabel()
                            }
                        }, {
                            key: "drawHighlight",
                            value: function(t, e) {
                                this.canvas.save(), this.canvas.beginPath(), this.canvas.strokeStyle = this.tree.highlightColour, this.canvas.lineWidth = this.getHighlightLineWidth();
                                var n = this.getHighlightRadius();
                                this.canvas.arc(t, e, n, 0, u.FULL, !1), this.canvas.stroke(), this.canvas.closePath(), this.canvas.restore()
                            }
                        }, {
                            key: "drawBranchLabels",
                            value: function() {
                                this.canvas.save();
                                var t = this.internalLabelStyle || this.tree.internalLabelStyle;
                                this.canvas.fillStyle = t.colour, this.canvas.font = t.format + " " + t.textSize + "pt " + t.font, this.canvas.textBaseline = "middle", this.canvas.textAlign = "center";
                                var e = 2 * this.canvas.measureText("M").width / 3,
                                    n = "y" === this.tree.type.branchScalingAxis ? this.centerx : (this.startx + this.centerx) / 2,
                                    r = "x" === this.tree.type.branchScalingAxis ? this.centery : (this.starty + this.centery) / 2;
                                this.tree.showBranchLengthLabels && this.tree.branchLengthLabelPredicate(this) && this.canvas.fillText(this.branchLength.toFixed(2), n, r + e), this.tree.showInternalNodeLabels && !this.leaf && this.label && this.canvas.fillText(this.label, n, r - e), this.canvas.restore()
                            }
                        }, {
                            key: "drawNode",
                            value: function() {
                                var t = this.getRadius(),
                                    e = t,
                                    n = this.leaf ? e * Math.cos(this.angle) + this.centerx : this.centerx,
                                    r = this.leaf ? e * Math.sin(this.angle) + this.centery : this.centery;
                                this.setNodeDimensions(n, r, t), this.collapsed ? this.drawCollapsed(n, r) : this.leaf && (this.canvas.save(), this.canvas.translate(this.centerx, this.centery), this.canvas.rotate(this.angle), this.drawLeaf(), this.canvas.restore()), this.isHighlighted && this.tree.highlighters.push(this.drawHighlight.bind(this, n, r)), (this.tree.root !== this && this.tree.showBranchLengthLabels || this.tree.showInternalNodeLabels) && this.drawBranchLabels()
                            }
                        }, {
                            key: "getChildProperties",
                            value: function(t) {
                                if (this.leaf) return [this[t]];
                                for (var e = [], n = 0; n < this.children.length; n++) e = e.concat(this.children[n].getChildProperties(t));
                                return e
                            }
                        }, {
                            key: "getChildCount",
                            value: function() {
                                if (this.leaf) return 1;
                                for (var t = 0, e = 0; e < this.children.length; e++) t += this.children[e].getChildCount();
                                return t
                            }
                        }, {
                            key: "getChildYTotal",
                            value: function() {
                                if (this.leaf) return this.centery;
                                for (var t = 0, e = 0; e < this.children.length; e++) t += this.children[e].getChildYTotal();
                                return t
                            }
                        }, {
                            key: "cascadeFlag",
                            value: function(t, e, n) {
                                if ("undefined" == typeof this[t]) throw new Error("Unknown property: " + t);
                                ("undefined" == typeof n || n(this, t, e)) && (this[t] = e);
                                var r = !0,
                                    a = !1,
                                    i = void 0;
                                try {
                                    for (var o, s = this.children[Symbol.iterator](); !(r = (o = s.next()).done); r = !0) {
                                        var l = o.value;
                                        l.cascadeFlag(t, e, n)
                                    }
                                } catch (t) {
                                    a = !0, i = t
                                } finally {
                                    try {
                                        !r && s.return && s.return()
                                    } finally {
                                        if (a) throw i
                                    }
                                }
                            }
                        }, {
                            key: "reset",
                            value: function() {
                                var t, e;
                                for (this.startx = 0, this.starty = 0, this.centerx = 0, this.centery = 0, this.angle = null, this.minChildAngle = u.FULL, this.maxChildAngle = 0, e = 0; e < this.children.length; e++) try {
                                    this.children[t].reset()
                                } catch (t) {
                                    return t
                                }
                            }
                        }, {
                            key: "redrawTreeFromBranch",
                            value: function() {
                                this.collapsed && this.expand(), this.tree.redrawFromBranch(this)
                            }
                        }, {
                            key: "extractChildren",
                            value: function() {
                                var t = !0,
                                    e = !1,
                                    n = void 0;
                                try {
                                    for (var r, a = this.children[Symbol.iterator](); !(t = (r = a.next()).done); t = !0) {
                                        var i = r.value;
                                        this.tree.storeNode(i), i.extractChildren()
                                    }
                                } catch (t) {
                                    e = !0, n = t
                                } finally {
                                    try {
                                        !t && a.return && a.return()
                                    } finally {
                                        if (e) throw n
                                    }
                                }
                            }
                        }, {
                            key: "hasCollapsedAncestor",
                            value: function() {
                                return !!this.parent && (this.parent.collapsed || this.parent.hasCollapsedAncestor())
                            }
                        }, {
                            key: "collapse",
                            value: function() {
                                this.collapsed = this.leaf === !1
                            }
                        }, {
                            key: "expand",
                            value: function() {
                                this.collapsed = !1
                            }
                        }, {
                            key: "toggleCollapsed",
                            value: function() {
                                this.collapsed ? this.expand() : this.collapse()
                            }
                        }, {
                            key: "setTotalLength",
                            value: function() {
                                var t;
                                for (this.parent ? (this.totalBranchLength = this.parent.totalBranchLength + this.branchLength, this.totalBranchLength > this.tree.maxBranchLength && (this.tree.maxBranchLength = this.totalBranchLength)) : (this.totalBranchLength = this.branchLength, this.tree.maxBranchLength = this.totalBranchLength), t = 0; t < this.children.length; t++) this.children[t].setTotalLength()
                            }
                        }, {
                            key: "addChild",
                            value: function(t) {
                                t.parent = this, t.tree = this.tree, this.leaf = !1, this.children.push(t)
                            }
                        }, {
                            key: "getChildColours",
                            value: function() {
                                var t = [];
                                return this.children.forEach(function(e) {
                                    var n = 0 === e.children.length ? e.colour : e.getColour();
                                    t.indexOf(n) === -1 && t.push(n)
                                }), t
                            }
                        }, {
                            key: "getColour",
                            value: function(t) {
                                return this.selected ? this.tree.selectedColour : t || this.colour || this.tree.branchColour
                            }
                        }, {
                            key: "getNwk",
                            value: function() {
                                var t = !(arguments.length > 0 && void 0 !== arguments[0]) || arguments[0];
                                if (this.leaf) return this.label + ":" + this.branchLength;
                                var e = this.children.map(function(t) {
                                    return t.getNwk(!1)
                                });
                                return "(" + e.join(",") + "):" + this.branchLength + (t ? ";" : "")
                            }
                        }, {
                            key: "getTextColour",
                            value: function() {
                                if (this.selected) return this.tree.selectedColour;
                                if (this.isHighlighted) return this.tree.highlightColour;
                                if (this.tree.backColour && this.children.length) {
                                    var t = this.getChildColours();
                                    if (1 === t.length) return t[0]
                                }
                                return this.labelStyle.colour || this.colour || this.tree.branchColour
                            }
                        }, {
                            key: "getLabel",
                            value: function() {
                                return void 0 !== this.label && null !== this.label ? this.label : ""
                            }
                        }, {
                            key: "getTextSize",
                            value: function() {
                                return this.labelStyle.textSize || this.tree.textSize
                            }
                        }, {
                            key: "getFontString",
                            value: function() {
                                var t = this.labelStyle.font || this.tree.font;
                                return (this.labelStyle.format || "") + " " + this.getTextSize() + "pt " + t
                            }
                        }, {
                            key: "getLabelSize",
                            value: function() {
                                return this.canvas.font = this.getFontString(), this.canvas.measureText(this.getLabel()).width
                            }
                        }, {
                            key: "getRadius",
                            value: function() {
                                var t = this.tree.baseNodeSize;
                                return this.leaf ? t * this.radius : t / this.radius
                            }
                        }, {
                            key: "getDiameter",
                            value: function() {
                                return 2 * this.getRadius()
                            }
                        }, {
                            key: "hasLabelConnector",
                            value: function() {
                                return !!this.tree.alignLabels && this.tree.labelAlign.getLabelOffset(this) > this.getDiameter()
                            }
                        }, {
                            key: "getLabelStartX",
                            value: function() {
                                var t = this.getLeafStyle(),
                                    e = (t.lineWidth, this.hasLabelConnector()),
                                    n = this.getDiameter();
                                return this.isHighlighted && !e && (n += this.getHighlightSize() - this.getRadius()), n + Math.min(this.tree.labelPadding, this.tree.labelPadding / this.tree.zoom)
                            }
                        }, {
                            key: "getHighlightLineWidth",
                            value: function() {
                                return this.tree.highlightWidth / this.tree.zoom
                            }
                        }, {
                            key: "getHighlightRadius",
                            value: function() {
                                var t = this.getHighlightLineWidth() * this.tree.highlightSize;
                                return t += this.getLeafStyle().lineWidth / this.tree.highlightSize, this.leaf ? this.getRadius() + t : .666 * t
                            }
                        }, {
                            key: "getHighlightSize",
                            value: function() {
                                return this.getHighlightRadius() + this.getHighlightLineWidth()
                            }
                        }, {
                            key: "rotate",
                            value: function() {
                                for (var t = [], e = this.children.length; e--;) t.push(this.children[e]);
                                this.children = t, this.tree.extractNestedBranches(), this.tree.draw(!0)
                            }
                        }, {
                            key: "getChildNo",
                            value: function() {
                                return this.parent.children.indexOf(this)
                            }
                        }, {
                            key: "setDisplay",
                            value: function(t) {
                                var e = t.colour,
                                    n = t.shape,
                                    r = t.size,
                                    a = t.leafStyle,
                                    i = t.labelStyle;
                                e && (this.colour = e), n && (this.nodeShape = f[n] ? f[n] : n), r && (this.radius = r), a && (this.leafStyle = a), i && (this.labelStyle = i)
                            }
                        }, {
                            key: "getTotalLength",
                            value: function() {
                                var t = this.getRadius();
                                return (this.tree.showLabels || this.tree.hoverLabel && this.isHighlighted) && (t += this.getLabelStartX() + this.getLabelSize()), t
                            }
                        }, {
                            key: "getBounds",
                            value: function() {
                                var t = this.tree,
                                    e = t.alignLabels ? t.labelAlign.getX(this) : this.centerx,
                                    n = t.alignLabels ? t.labelAlign.getY(this) : this.centery,
                                    r = this.getRadius(),
                                    a = this.getTotalLength(),
                                    i = void 0,
                                    o = void 0,
                                    s = void 0,
                                    l = void 0;
                                this.angle > u.QUARTER && this.angle < u.HALF + u.QUARTER ? (i = e + a * Math.cos(this.angle), s = n + a * Math.sin(this.angle), o = e - r, l = n - r) : (i = e - r, s = n - r, o = e + a * Math.cos(this.angle), l = n + a * Math.sin(this.angle));
                                var c = t.prerenderer.getStep(t) / 2;
                                return d.minx = Math.min(i, o, e - c), d.miny = Math.min(s, l, n - c), d.maxx = Math.max(i, o, e + c), d.maxy = Math.max(s, l, n + c), d
                            }
                        }, {
                            key: "getLeafStyle",
                            value: function() {
                                var t = this.leafStyle,
                                    e = t.strokeStyle,
                                    n = t.fillStyle,
                                    r = this.tree.zoom;
                                C.strokeStyle = this.getColour(e), C.fillStyle = this.getColour(n);
                                var a = "undefined" != typeof this.leafStyle.lineWidth ? this.leafStyle.lineWidth : this.tree.lineWidth;
                                return C.lineWidth = a / r, C
                            }
                        }, {
                            key: "isHighlighted",
                            get: function() {
                                return this.highlighted || this.hovered
                            }
                        }, {
                            key: "canvas",
                            get: function() {
                                return this.tree.canvas
                            }
                        }], [{
                            key: "generateId",
                            value: function() {
                                return "pcn" + this.lastId++
                            }
                        }]), t
                    }();
                v.lastId = 0, e.default = v
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(9),
                    i = r(a),
                    o = n(14),
                    s = r(o),
                    l = n(17),
                    c = r(l),
                    h = n(20),
                    u = r(h),
                    f = n(23),
                    d = r(f);
                e.default = {
                    rectangular: i.default,
                    circular: s.default,
                    radial: c.default,
                    diagonal: u.default,
                    hierarchical: d.default
                }
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(10),
                    i = r(a),
                    o = n(11),
                    s = r(o),
                    l = n(12),
                    c = r(l),
                    h = n(13),
                    u = r(h),
                    f = n(6),
                    d = {
                        getX: function(t) {
                            return t.tree.farthestNodeFromRootX * t.tree.currentBranchScale
                        },
                        getY: function(t) {
                            return t.centery
                        },
                        getLabelOffset: function(t) {
                            return t.tree.farthestNodeFromRootX * t.tree.currentBranchScale - t.centerx
                        }
                    };
                e.default = {
                    branchRenderer: new i.default(c.default),
                    prerenderer: new s.default(u.default),
                    labelAlign: d,
                    branchScalingAxis: "x",
                    getCollapsedMeasurements: function(t) {
                        return {
                            angle: f.Angles.QUARTER,
                            radius: t.tree.step * t.getNumberOfLeaves()
                        }
                    }
                }
            }, function(t, e) {
                "use strict";

                function n(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var r = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }(),
                    a = function() {
                        function t(e) {
                            if (n(this, t), !e || !e.draw) throw new Error("`draw` function is required for branch renderers");
                            this.draw = e.draw, this.prepareChild = e.prepareChild
                        }
                        return r(t, [{
                            key: "render",
                            value: function(t, e, n) {
                                var r;
                                if (!n && e && (e.selected ? e.canvas.fillStyle = t.selectedColour : e.canvas.fillStyle = e.colour, e.canvas.strokeStyle = e.getColour(), this.draw(t, e), !e.pruned))
                                    for (e.drawNode(), r = 0; r < e.children.length; r++) this.prepareChild && this.prepareChild(e, e.children[r]), this.render(t, e.children[r], e.collapsed || n)
                            }
                        }]), t
                    }();
                e.default = a
            }, function(t, e) {
                "use strict";

                function n(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var r = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }(),
                    a = function() {
                        function t(e) {
                            n(this, t), this.getStep = e.getStep, this.calculate = e.calculate
                        }
                        return r(t, [{
                            key: "run",
                            value: function(t) {
                                var e = this.getStep(t);
                                t.root.startx = 0, t.root.starty = 0, t.root.centerx = 0, t.root.centery = 0, t.farthestNodeFromRootX = 0, t.farthestNodeFromRootY = 0, t.currentBranchScale = 1, t.step = e, this.calculate(t, e), t.initialBranchScalar = t.branchScalar, t.root.startx = t.root.centerx, t.root.starty = t.root.centery, t.setFontSize(e), t.setMaxLabelLength()
                            }
                        }]), t
                    }();
                e.default = a
            }, function(t, e) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.default = {
                    draw: function(t, e) {
                        var n = e.branchLength * t.branchScalar;
                        e.angle = 0, e.parent && (e.centerx = e.startx + n), e.canvas.beginPath(), e.canvas.moveTo(e.startx, e.starty), e.canvas.lineTo(e.startx, e.centery), e.canvas.lineTo(e.centerx, e.centery), e.canvas.stroke(), e.canvas.closePath()
                    },
                    prepareChild: function(t, e) {
                        e.startx = t.centerx, e.starty = t.centery
                    }
                }
            }, function(t, e) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.default = {
                    getStep: function(t) {
                        return t.fillCanvas ? t.canvas.canvas.height / t.leaves.length : Math.max(t.canvas.canvas.height / t.leaves.length, t.leaves[0].getDiameter() + t.labelPadding)
                    },
                    calculate: function(t, e) {
                        t.branchScalar = t.canvas.canvas.width / t.maxBranchLength;
                        for (var n = 0; n < t.leaves.length; n++) {
                            t.leaves[n].angle = 0, t.leaves[n].centery = n > 0 ? t.leaves[n - 1].centery + e : 0, t.leaves[n].centerx = t.leaves[n].totalBranchLength * t.branchScalar, t.leaves[n].centerx > t.farthestNodeFromRootX && (t.farthestNodeFromRootX = t.leaves[n].centerx), t.leaves[n].centery > t.farthestNodeFromRootY && (t.farthestNodeFromRootY = t.leaves[n].centery);
                            for (var r = t.leaves[n]; r.parent; r = r.parent) {
                                var a = r.parent.children;
                                r.parent.centery = (a[0].centery + a[a.length - 1].centery) / 2
                            }
                        }
                    }
                }
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(10),
                    i = r(a),
                    o = n(11),
                    s = r(o),
                    l = n(15),
                    c = r(l),
                    h = n(16),
                    u = r(h),
                    f = {
                        getX: function(t) {
                            return t.centerx + t.labelOffsetX + t.getDiameter() * Math.cos(t.angle)
                        },
                        getY: function(t) {
                            return t.centery + t.labelOffsetY + t.getDiameter() * Math.sin(t.angle)
                        },
                        getLabelOffset: function(t) {
                            return t.labelOffsetX / Math.cos(t.angle)
                        }
                    };
                e.default = {
                    branchRenderer: new i.default(c.default),
                    prerenderer: new s.default(u.default),
                    labelAlign: f,
                    getCollapsedMeasurements: function(t) {
                        var e = t.tree,
                            n = e.maxBranchLength,
                            r = e.branchScalar,
                            a = e.step;
                        return {
                            angle: t.getNumberOfLeaves() * a,
                            radius: (n - t.totalBranchLength) * r
                        }
                    },
                    calculateFontSize: function(t) {
                        return Math.min(10 * t + 4, 40)
                    }
                }
            }, function(t, e) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.default = {
                    draw: function(t, e) {
                        var n = e.totalBranchLength * t.branchScalar;
                        e.canvas.beginPath(), e.canvas.moveTo(e.startx, e.starty), e.canvas.lineTo(e.centerx, e.centery), e.canvas.stroke(), e.canvas.closePath(), e.canvas.strokeStyle = e.getColour(), e.children.length > 1 && !e.collapsed && (e.canvas.beginPath(), e.canvas.arc(0, 0, n, e.minChildAngle, e.maxChildAngle, e.maxChildAngle < e.minChildAngle), e.canvas.stroke(), e.canvas.closePath())
                    }
                }
            }, function(t, e, n) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var r = n(2),
                    a = r.constants.Angles;
                e.default = {
                    getStep: function(t) {
                        return a.FULL / t.leaves.length
                    },
                    calculate: function(t, e) {
                        t.branchScalar = Math.min(t.canvas.canvas.width, t.canvas.canvas.height) / t.maxBranchLength;
                        var n = t.leaves.length * t.leaves[0].getDiameter() / a.FULL;
                        t.branchScalar * t.maxBranchLength > n ? n = t.branchScalar * t.maxBranchLength : t.branchScalar = n / t.maxBranchLength;
                        for (var r = 0; r < t.leaves.length; r++) {
                            var i = t.leaves[r];
                            for (i.angle = e * r, i.startx = i.parent.totalBranchLength * t.branchScalar * Math.cos(i.angle), i.starty = i.parent.totalBranchLength * t.branchScalar * Math.sin(i.angle), i.centerx = i.totalBranchLength * t.branchScalar * Math.cos(i.angle), i.centery = i.totalBranchLength * t.branchScalar * Math.sin(i.angle), i.labelOffsetX = n * Math.cos(i.angle) - i.centerx, i.labelOffsetY = n * Math.sin(i.angle) - i.centery; i.parent && (0 === i.getChildNo() && (i.parent.angle = i.angle, i.parent.minChildAngle = i.angle), i.getChildNo() === i.parent.children.length - 1); i = i.parent) i.parent.maxChildAngle = i.angle, i.parent.angle = (i.parent.minChildAngle + i.parent.maxChildAngle) / 2, i.parent.startx = (i.parent.totalBranchLength - i.parent.branchLength) * t.branchScalar * Math.cos(i.parent.angle), i.parent.starty = (i.parent.totalBranchLength - i.parent.branchLength) * t.branchScalar * Math.sin(i.parent.angle), i.parent.centerx = i.parent.totalBranchLength * t.branchScalar * Math.cos(i.parent.angle), i.parent.centery = i.parent.totalBranchLength * t.branchScalar * Math.sin(i.parent.angle)
                        }
                    }
                }
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(10),
                    i = r(a),
                    o = n(11),
                    s = r(o),
                    l = n(18),
                    c = r(l),
                    h = n(19),
                    u = r(h);
                e.default = {
                    branchRenderer: new i.default(c.default),
                    prerenderer: new s.default(u.default),
                    getCollapsedMeasurements: function(t) {
                        var e = t.tree,
                            n = e.maxBranchLength,
                            r = e.branchScalar,
                            a = e.step;
                        return {
                            angle: t.getNumberOfLeaves() * a,
                            radius: (n - t.totalBranchLength) * r
                        }
                    },
                    calculateFontSize: function(t) {
                        return Math.min(50 * t + 5, 15)
                    }
                }
            }, function(t, e) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.default = {
                    draw: function(t, e) {
                        e.canvas.beginPath(), e.canvas.moveTo(e.startx, e.starty), e.canvas.lineTo(e.centerx, e.centery), e.canvas.stroke(), e.canvas.closePath()
                    }
                }
            }, function(t, e, n) {
                "use strict";

                function r(t, e) {
                    e.parent ? (e.startx = e.parent.centerx, e.starty = e.parent.centery) : (e.startx = 0, e.starty = 0), e.centerx = e.startx + e.branchLength * t.branchScalar * Math.cos(e.angle), e.centery = e.starty + e.branchLength * t.branchScalar * Math.sin(e.angle);
                    for (var n = 0; n < e.children.length; n++) r(t, e.children[n])
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(2),
                    i = a.constants.Angles;
                e.default = {
                    getStep: function(t) {
                        return i.FULL / t.leaves.length
                    },
                    calculate: function(t, e) {
                        t.branchScalar = Math.min(t.canvas.canvas.width, t.canvas.canvas.height) / t.maxBranchLength;
                        for (var n = 0; n < t.leaves.length; n += 1) {
                            t.leaves[n].angle = e * n, t.leaves[n].centerx = t.leaves[n].totalBranchLength * t.branchScalar * Math.cos(t.leaves[n].angle), t.leaves[n].centery = t.leaves[n].totalBranchLength * t.branchScalar * Math.sin(t.leaves[n].angle);
                            for (var a = t.leaves[n]; a.parent && (0 === a.getChildNo() && (a.parent.angle = 0), a.parent.angle += a.angle * a.getChildCount(), a.getChildNo() === a.parent.children.length - 1); a = a.parent) a.parent.angle = a.parent.angle / a.parent.getChildCount()
                        }
                        r(t, t.root)
                    }
                }
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(10),
                    i = r(a),
                    o = n(11),
                    s = r(o),
                    l = n(21),
                    c = r(l),
                    h = n(22),
                    u = r(h),
                    f = n(6);
                e.default = {
                    branchRenderer: new i.default(c.default),
                    prerenderer: new s.default(u.default),
                    calculateFontSize: function(t) {
                        return Math.min(t / 2, 10)
                    },
                    getCollapsedMeasurements: function(t) {
                        return {
                            angle: f.Angles.QUARTER,
                            radius: t.tree.step * t.getNumberOfLeaves()
                        }
                    }
                }
            }, function(t, e) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.default = {
                    draw: function(t, e) {
                        e.angle = 0, e.canvas.beginPath(), e.canvas.moveTo(e.startx, e.starty), e.canvas.lineTo(e.centerx, e.centery), e.canvas.stroke(), e.canvas.closePath()
                    },
                    prepareChild: function(t, e) {
                        e.startx = t.centerx, e.starty = t.centery
                    }
                }
            }, function(t, e, n) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var r = n(2),
                    a = r.constants.Angles;
                e.default = {
                    getStep: function(t) {
                        return Math.max(t.canvas.canvas.height / t.leaves.length, t.leaves[0].getDiameter() + t.labelPadding)
                    },
                    calculate: function(t, e) {
                        for (var n = 0; n < t.leaves.length; n++) {
                            t.leaves[n].centerx = 0, t.leaves[n].centery = n > 0 ? t.leaves[n - 1].centery + e : 0, t.leaves[n].angle = 0;
                            for (var r = t.leaves[n]; r.parent && r.getChildNo() === r.parent.children.length - 1; r = r.parent) {
                                r.parent.centery = r.parent.getChildYTotal() / r.parent.getChildCount(), r.parent.centerx = r.parent.children[0].centerx + (r.parent.children[0].centery - r.parent.centery) * Math.tan(a.FORTYFIVE);
                                for (var i = 0; i < r.parent.children.length; i++) r.parent.children[i].startx = r.parent.centerx, r.parent.children[i].starty = r.parent.centery
                            }
                        }
                    }
                }
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(10),
                    i = r(a),
                    o = n(11),
                    s = r(o),
                    l = n(24),
                    c = r(l),
                    h = n(25),
                    u = r(h),
                    f = n(6),
                    d = {
                        getX: function(t) {
                            return t.centerx
                        },
                        getY: function(t) {
                            return t.tree.farthestNodeFromRootY * t.tree.currentBranchScale
                        },
                        getLabelOffset: function(t) {
                            return t.tree.farthestNodeFromRootY * t.tree.currentBranchScale - t.centery
                        }
                    };
                e.default = {
                    branchRenderer: new i.default(c.default),
                    prerenderer: new s.default(u.default),
                    labelAlign: d,
                    branchScalingAxis: "y",
                    getCollapsedMeasurements: function(t) {
                        return {
                            angle: f.Angles.QUARTER,
                            radius: t.tree.step * t.getNumberOfLeaves()
                        }
                    }
                }
            }, function(t, e) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.default = {
                    draw: function(t, e) {
                        var n = e.branchLength * t.branchScalar;
                        e.parent && (e.centery = e.starty + n), e.canvas.beginPath(), e !== e.tree.root && (e.canvas.moveTo(e.startx, e.starty), e.canvas.lineTo(e.centerx, e.starty)), e.canvas.lineTo(e.centerx, e.centery), e.canvas.stroke(), e.canvas.closePath()
                    },
                    prepareChild: function(t, e) {
                        e.startx = t.centerx, e.starty = t.centery
                    }
                }
            }, function(t, e, n) {
                "use strict";
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var r = n(2),
                    a = r.constants.Angles;
                e.default = {
                    getStep: function(t) {
                        return t.fillCanvas ? t.canvas.canvas.width / t.leaves.length : Math.max(t.canvas.canvas.width / t.leaves.length, t.leaves[0].getDiameter() + t.labelPadding)
                    },
                    calculate: function(t, e) {
                        t.branchScalar = t.canvas.canvas.height / t.maxBranchLength;
                        for (var n = 0; n < t.leaves.length; n++) {
                            t.leaves[n].angle = a.QUARTER, t.leaves[n].centerx = n > 0 ? t.leaves[n - 1].centerx + e : 0, t.leaves[n].centery = t.leaves[n].totalBranchLength * t.branchScalar;
                            for (var r = t.leaves[n]; r.parent && (0 === r.getChildNo() && (r.parent.centerx = r.centerx), r.getChildNo() === r.parent.children.length - 1); r = r.parent) {
                                r.parent.angle = a.QUARTER, r.parent.centerx = (r.parent.centerx + r.centerx) / 2, r.parent.centery = r.parent.totalBranchLength * t.branchScalar;
                                for (var i = 0; i < r.parent.children.length; i++) r.parent.children[i].startx = r.parent.centerx, r.parent.children[i].starty = r.parent.centery
                            }
                            t.leaves[n].centerx > t.farthestNodeFromRootX && (t.farthestNodeFromRootX = t.leaves[n].centerx), t.leaves[n].centery > t.farthestNodeFromRootY && (t.farthestNodeFromRootY = t.leaves[n].centery)
                        }
                    }
                }
            }, function(t, e, n) {
                "use strict";

                function r(t, e) {
                    t.beginPath(), t.moveTo(0, 0), t.lineTo(e, 0), t.stroke(), t.closePath()
                }

                function a(t, e) {
                    var n = e.lineWidth,
                        r = e.strokeStyle,
                        a = e.fillStyle;
                    t.lineWidth = n, t.strokeStyle = r, t.fillStyle = a, t.fill(), n > 0 && r !== a && t.stroke()
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var i = n(2),
                    o = i.constants.Angles,
                    s = function(t) {
                        return t * Math.sqrt(2)
                    };
                e.default = {
                    circle: function(t, e, n) {
                        var i = Math.pow(s(e), 2),
                            l = Math.sqrt(i / Math.PI);
                        r(t, e - l), t.beginPath(), t.arc(e, 0, l, 0, o.FULL, !1), t.closePath(), a(t, n)
                    },
                    square: function(t, e, n) {
                        var i = s(e),
                            o = e - i / 2;
                        r(t, o), t.beginPath(), t.moveTo(o, 0), t.lineTo(o, i / 2), t.lineTo(o + i, i / 2), t.lineTo(o + i, -i / 2), t.lineTo(o, -i / 2), t.lineTo(o, 0), t.closePath(), a(t, n)
                    },
                    star: function(t, e, n) {
                        var i = e,
                            o = 0,
                            s = 5,
                            l = e,
                            c = .5 * l,
                            h = Math.PI / s;
                        r(t, l - c);
                        var u = Math.PI / 2 * 3;
                        t.beginPath(), t.moveTo(i, o - l);
                        for (var f = 0; f < s; f++) {
                            var d = i + Math.cos(u) * l,
                                C = o + Math.sin(u) * l;
                            t.lineTo(d, C), u += h, d = i + Math.cos(u) * c, C = o + Math.sin(u) * c, t.lineTo(d, C), u += h
                        }
                        t.lineTo(i, o - l), t.closePath(), a(t, n)
                    },
                    triangle: function(t, e, n) {
                        var i = 2 * e * Math.cos(30 * Math.PI / 180),
                            o = Math.sqrt(3) / 2 * i,
                            s = 1 / Math.sqrt(3) * (i / 2);
                        r(t, e - s), t.beginPath(), t.moveTo(e, s), t.lineTo(e + i / 2, s), t.lineTo(e, -(o - s)), t.lineTo(e - i / 2, s), t.lineTo(e, s), t.closePath(), a(t, n)
                    }
                }
            }, function(t, e) {
                "use strict";

                function n(t, e) {
                    if (!t) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
                    return !e || "object" != typeof e && "function" != typeof e ? t : e
                }

                function r(t, e) {
                    if ("function" != typeof e && null !== e) throw new TypeError("Super expression must either be null or a function, not " + typeof e);
                    t.prototype = Object.create(e && e.prototype, {
                        constructor: {
                            value: t,
                            enumerable: !1,
                            writable: !0,
                            configurable: !0
                        }
                    }), e && (Object.setPrototypeOf ? Object.setPrototypeOf(t, e) : t.__proto__ = e)
                }

                function a(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var i = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }(),
                    o = function() {
                        function t(e) {
                            var n = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {},
                                r = n.className,
                                i = void 0 === r ? "phylocanvas-tooltip" : r,
                                o = n.element,
                                s = void 0 === o ? document.createElement("div") : o,
                                l = n.zIndex,
                                c = void 0 === l ? 2e3 : l,
                                h = n.parent,
                                u = void 0 === h ? e.containerElement : h;
                            a(this, t), this.tree = e, this.element = s, this.element.className = i, this.element.style.display = "none", this.element.style.position = "fixed", this.element.style.zIndex = c, this.closed = !0, u.appendChild(this.element)
                        }
                        return i(t, [{
                            key: "close",
                            value: function() {
                                this.element.style.display = "none", this.closed = !0
                            }
                        }, {
                            key: "open",
                            value: function() {
                                for (var t = arguments.length > 0 && void 0 !== arguments[0] ? arguments[0] : 100, e = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : 100, n = arguments[2]; this.element.hasChildNodes();) this.element.removeChild(this.element.firstChild);
                                this.createContent(n), this.element.style.top = e + "px", this.element.style.left = t + "px", this.element.style.display = "block", this.closed = !1
                            }
                        }, {
                            key: "createContent",
                            value: function() {
                                throw new Error("Not implemented")
                            }
                        }]), t
                    }();
                e.default = o;
                e.ChildNodesTooltip = function(t) {
                    function e(t, r) {
                        a(this, e);
                        var i = n(this, (e.__proto__ || Object.getPrototypeOf(e)).call(this, t, r));
                        return i.element.style.background = "rgba(97, 97, 97, 0.9)", i.element.style.color = "#fff", i.element.style.cursor = "pointer", i.element.style.padding = "8px", i.element.style.marginTop = "16px", i.element.style.borderRadius = "2px", i.element.style.textAlign = "center", i.element.style.fontFamily = i.tree.font || "sans-serif", i.element.style.fontSize = "10px", i.element.style.fontWeight = "500", i
                    }
                    return r(e, t), i(e, [{
                        key: "createContent",
                        value: function(t) {
                            var e = document.createTextNode(t.getChildProperties("id").length);
                            this.element.appendChild(e)
                        }
                    }]), e
                }(o)
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(29),
                    i = r(a),
                    o = n(30),
                    s = r(o),
                    l = n(31),
                    c = r(l);
                e.default = {
                    nexus: new i.default(c.default),
                    newick: new i.default(s.default)
                }
            }, function(t, e) {
                "use strict";

                function n(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var r = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }(),
                    a = function() {
                        function t(e) {
                            var r = e.format,
                                a = e.parseFn,
                                i = e.fileExtension,
                                o = e.validator;
                            n(this, t), this.format = r, this.parseFn = a, this.fileExtension = i, this.validator = o
                        }
                        return r(t, [{
                            key: "parse",
                            value: function(t, e) {
                                var n = t.formatString,
                                    r = t.root,
                                    a = t.options,
                                    i = void 0 === a ? {
                                        validate: !0
                                    } : a;
                                return n.match(this.validator) || i.validate === !1 ? this.parseFn({
                                    string: n,
                                    root: r,
                                    options: i
                                }, e) : e(new Error('Format string does not validate as "' + this.format + '"'))
                            }
                        }]), t
                    }();
                e.default = a
            }, function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }

                function a(t) {
                    return this === t
                }

                function i(t) {
                    var e = "",
                        n = !0,
                        r = !1,
                        i = void 0;
                    try {
                        for (var o, s = t[Symbol.iterator](); !(n = (o = s.next()).done); n = !0) {
                            var l = o.value;
                            if (v.some(a.bind(l))) break;
                            e += l
                        }
                    } catch (t) {
                        r = !0, i = t
                    } finally {
                        try {
                            !n && s.return && s.return()
                        } finally {
                            if (r) throw i
                        }
                    }
                    return e
                }

                function o(t, e) {
                    var n = t.split("**"),
                        r = {};
                    if (e.id = n[0], 1 !== n.length) {
                        n = n[1].split("*");
                        for (var a = 0; a < n.length; a += 2) {
                            var i = n[a + 1];
                            switch (n[a]) {
                                case "nsz":
                                    r.size = window.parseInt(i);
                                    break;
                                case "nsh":
                                    r.shape = i;
                                    break;
                                case "ncol":
                                    r.colour = i
                            }
                        }
                        e.setDisplay(r)
                    }
                }

                function s(t) {
                    var e = "",
                        n = !0,
                        r = !1,
                        i = void 0;
                    try {
                        for (var o, s = t[Symbol.iterator](); !(n = (o = s.next()).done); n = !0) {
                            var l = o.value;
                            if (p.some(a.bind(l))) break;
                            e += l
                        }
                    } catch (t) {
                        r = !0, i = t
                    } finally {
                        try {
                            !n && s.return && s.return()
                        } finally {
                            if (r) throw i
                        }
                    }
                    return e
                }

                function l(t, e, n) {
                    var r = i(e.slice(n)),
                        a = n + r.length,
                        l = "";
                    return r.match(/\*/) && o(r, t), ":" === e[a] ? (l = s(e.slice(a + 1)), t.branchLength = Math.max(parseFloat(l), 0)) : t.branchLength = 0, r && (t.label = r), t.id = r || u.default.generateId(), a + l.length
                }

                function c(t, e) {
                    for (var n = t.string, r = t.root, a = n.replace(/(\r|\n)/g, ""), i = r, o = 0; o < a.length; o++) {
                        var s = void 0;
                        switch (a[o]) {
                            case "(":
                                s = new u.default, i.addChild(s), i = s;
                                break;
                            case ")":
                                i = i.parent;
                                break;
                            case ",":
                                s = new u.default, i.parent.addChild(s), i = s;
                                break;
                            case ";":
                                break;
                            default:
                                try {
                                    o = l(i, a, o)
                                } catch (t) {
                                    return e(t)
                                }
                        }
                    }
                    return e()
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var h = n(7),
                    u = r(h),
                    f = "newick",
                    d = /\.nwk$/,
                    C = /^[\w\W\.\*\:(\),-\/]+;?\s*$/gi,
                    v = [":", ",", ")", ";"],
                    p = [")", ",", ";"];
                e.default = {
                    format: f,
                    fileExtension: d,
                    validator: C,
                    parseFn: c
                }
            }, function(t, e, n) {
                "use strict";

                function r(t, e) {
                    var n = t.string,
                        r = t.root,
                        i = t.options;
                    if (!n.match(/BEGIN TREES/gi)) return e(new Error("The nexus file does not contain a tree block"));
                    var o = i.name,
                        s = n.match(/BEGIN TREES;[\S\s]+END;/i)[0].replace(/BEGIN TREES;\n/i, "").replace(/END;/i, ""),
                        l = {},
                        c = s.match(/TRANSLATE[^;]+;/i);
                    if (c && c.length) {
                        c = c[0], s = s.replace(c, ""), c = c.replace(/translate|;/gi, "");
                        for (var h = c.split(","), u = 0; u < h.length; u++) {
                            var f = h[u].trim().replace("\n", "").split(" ");
                            f[0] && f[1] && (l[f[0].trim()] = f[1].trim())
                        }
                    }
                    for (var d = s.split("\n"), C = {}, v = 0; v < d.length; v++)
                        if ("" !== d[v].trim()) {
                            var p = d[v].replace(/tree\s/i, "");
                            o || (o = p.trim().match(/^\w+/)[0]), C[o] = p.trim().match(/[\S]*$/)[0]
                        } return C[o] ? void(0, a.parseFn)({
                        string: C[o].trim(),
                        root: r
                    }, function(t) {
                        if (t) return e(t);
                        if (e(), l) {
                            var n = !0,
                                a = !1,
                                i = void 0;
                            try {
                                for (var o, s = Object.keys(l)[Symbol.iterator](); !(n = (o = s.next()).done); n = !0) {
                                    var c = o.value,
                                        h = r.tree.branches,
                                        u = h[c];
                                    delete h[c], u.id = l[c], h[u.id] = u
                                }
                            } catch (t) {
                                a = !0, i = t
                            } finally {
                                try {
                                    !n && s.return && s.return()
                                } finally {
                                    if (a) throw i
                                }
                            }
                            r.tree.draw()
                        }
                    }) : new Error("tree " + o + " does not exist in this NEXUS file")
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var a = n(30),
                    i = "nexus",
                    o = /\.n(ex|xs)$/,
                    s = /^#NEXUS[\s\n;\w\W\.\*\:(\),-=\[\]\/&]+$/i;
                e.default = {
                    parseFn: r,
                    format: i,
                    fileExtension: o,
                    validator: s
                }
            }])
        })
    }, function(t, e, n) {
        ! function(e, r) {
            t.exports = r(n(3))
        }(this, function(t) {
            return function(t) {
                function e(r) {
                    if (n[r]) return n[r].exports;
                    var a = n[r] = {
                        exports: {},
                        id: r,
                        loaded: !1
                    };
                    return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
                }
                var n = {};
                return e.m = t, e.c = n, e.p = "", e(0)
            }([function(t, e, n) {
                "use strict";

                function r(t, e) {
                    var n = t.url,
                        r = t.method,
                        a = t.data,
                        i = new XMLHttpRequest;
                    i.onreadystatechange = function() {
                        4 === i.readyState && e(i)
                    }, i.open(r, n, !0), "GET" === r ? i.send() : i.send(a)
                }

                function a(t) {
                    t(o.Tree, "build", function(t, e) {
                        var n = this,
                            a = i(e, 3),
                            o = a[0],
                            s = a[1],
                            l = a[2];
                        l.ajax || o.match(s.fileExtension) ? r({
                            url: o,
                            method: "GET"
                        }, function(e) {
                            if (e.status >= 400) {
                                var r = new Error(e.responseText);
                                return l.callback && l.callback(r), n.loadError(r)
                            }
                            t.call(n, e.responseText, s, l)
                        }) : t.apply(this, e)
                    })
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var i = function() {
                    function t(t, e) {
                        var n = [],
                            r = !0,
                            a = !1,
                            i = void 0;
                        try {
                            for (var o, s = t[Symbol.iterator](); !(r = (o = s.next()).done) && (n.push(o.value), !e || n.length !== e); r = !0);
                        } catch (t) {
                            a = !0, i = t
                        } finally {
                            try {
                                !r && s.return && s.return()
                            } finally {
                                if (a) throw i
                            }
                        }
                        return n
                    }
                    return function(e, n) {
                        if (Array.isArray(e)) return e;
                        if (Symbol.iterator in Object(e)) return t(e, n);
                        throw new TypeError("Invalid attempt to destructure non-iterable instance")
                    }
                }();
                e.default = a;
                var o = n(1)
            }, function(e, n) {
                e.exports = t
            }])
        })
    }, function(t, e, n) {
        ! function(e, r) {
            t.exports = r(n(3))
        }(this, function(t) {
            return function(t) {
                function e(r) {
                    if (n[r]) return n[r].exports;
                    var a = n[r] = {
                        exports: {},
                        id: r,
                        loaded: !1
                    };
                    return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
                }
                var n = {};
                return e.m = t, e.c = n, e.p = "", e(0)
            }([function(t, e, n) {
                "use strict";

                function r(t) {
                    return t && t.__esModule ? t : {
                        default: t
                    }
                }

                function a(t) {
                    if (Array.isArray(t)) {
                        for (var e = 0, n = Array(t.length); e < t.length; e++) n[e] = t[e];
                        return n
                    }
                    return Array.from(t)
                }

                function i(t) {
                    return "circular" === t.treeType || "radial" === t.treeType
                }

                function o(t) {
                    return t.metadata.font ? t.metadata.font : Math.min(t.textSize, t.metadata.blockLength) + "pt " + t.font
                }

                function s(t) {
                    var e = t.metadata,
                        n = e.columns,
                        r = e.propertyName;
                    return n.length > 0 ? n : Object.keys(t.leaves[0][r])
                }

                function l(t) {
                    if (!t.metadata.showHeaders) return !1;
                    var e = t.treeType,
                        n = t.alignLabels;
                    return "diagonal" === e || n && "rectangular" === e || "hierarchical" === e
                }

                function c(t) {
                    var e = t.metadata,
                        n = e.showLabels,
                        r = e.blockLength,
                        a = e.padding,
                        i = e._maxLabelWidth,
                        o = s(t);
                    return (n ? o.reduce(function(t, e) {
                        return i[e]
                    }, 0) : 0) + o.length * (r + a)
                }

                function h(t) {
                    if (t.metadata._maxBlockSize) return t.metadata._maxBlockSize;
                    if (i(t)) {
                        var e = 0,
                            n = !0,
                            r = !1,
                            a = void 0;
                        try {
                            for (var o, s = t.leaves[Symbol.iterator](); !(n = (o = s.next()).done); n = !0) {
                                var l = o.value,
                                    c = l.getLabelStartX();
                                (t.showLabels || t.hoverLabel && l.highlighted) && (c += t.maxLabelLength[t.treeType]);
                                var h = t.alignLabels ? t.labelAlign.getLabelOffset(l) : 0,
                                    u = Math.hypot(l.centerx - l.startx, l.centery - l.starty) + c + h;
                                u > e && (e = u)
                            }
                        } catch (t) {
                            r = !0, a = t
                        } finally {
                            try {
                                !n && s.return && s.return()
                            } finally {
                                if (r) throw a
                            }
                        }
                        return t.metadata._maxBlockSize = b.FULL * e / t.leaves.length, t.metadata._maxBlockSize
                    }
                    return t.step
                }

                function u(t, e, n) {
                    var r = t.tree.canvas,
                        a = t.tree.treeType,
                        i = t.tree.metadata,
                        s = i._maxLabelWidth,
                        l = i._maxHeaderWidth,
                        c = i._maxHeaderHeight,
                        h = i.blockLength,
                        u = i.padding,
                        f = i.headerAngle,
                        d = i.showLabels,
                        C = i.fillStyle,
                        v = i.strokeStyle,
                        p = i.underlineHeaders,
                        g = t.tree.metadata.columns.length > 0 ? t.tree.metadata.columns : Object.keys(t.data),
                        y = t.tree.metadata.lineWidth / t.tree.zoom;
                    r.font = o(t.tree), r.fillStyle = C, r.strokeStyle = v, r.lineWidth = y;
                    var b = f / 180 * Math.PI,
                        m = n + c / 2 + Math.sin(b) * l / 2,
                        x = "hierarchical" === a ? -1 : 1,
                        w = e,
                        S = !0,
                        k = !1,
                        L = void 0;
                    try {
                        for (var _, E = g[Symbol.iterator](); !(S = (_ = E.next()).done); S = !0) {
                            var T = _.value,
                                M = h + (d ? s[T] : 0);
                            r.textAlign = "center", r.textBaseline = "middle";
                            var O = w + M / 2;
                            r.rotate(-b), r.fillText(T, Math.cos(b) * O + Math.sin(b) * x * m, Math.sin(b) * O + Math.cos(b) * -x * m), r.rotate(b), p && (r.beginPath(), r.moveTo(w, -x * n), r.lineTo(w + M, -x * n), r.stroke(), r.closePath()), w += M + u
                        }
                    } catch (t) {
                        k = !0, L = t
                    } finally {
                        try {
                            !S && E.return && E.return()
                        } finally {
                            if (k) throw L
                        }
                    }
                }

                function f(t) {
                    var e = t.tree.canvas,
                        n = t.tree,
                        r = t.tree.metadata,
                        a = r._maxLabelWidth,
                        s = r.blockSize,
                        c = r.blockLength,
                        f = r.padding,
                        d = r.propertyName,
                        C = r.fillStyle,
                        v = r.columns,
                        p = r.showLabels,
                        g = t.getLabelStartX(),
                        y = 0;
                    (n.showLabels || n.hoverLabel && t.highlighted) && (g += n.maxLabelLength[n.treeType]);
                    var m = h(n),
                        x = null !== s ? Math.min(m, s) : m;
                    n.alignLabels && (g += n.labelAlign.getLabelOffset(t)), g += f, y -= x / 2, !n.metadata._headingDrawn && l(n) && (u(t, g, x / 2 + f), n.metadata._headingDrawn = !0);
                    var w = this[d];
                    if (Object.keys(w).length > 0) {
                        e.beginPath();
                        var S = v.length > 0 ? v : Object.keys(w),
                            k = 1,
                            L = i(n) && n.alignLabels ? b.FULL * c / n.leaves.length : 0,
                            _ = o(n),
                            E = !0,
                            T = !1,
                            M = void 0;
                        try {
                            for (var O, P = S[Symbol.iterator](); !(E = (O = P.next()).done); E = !0) {
                                var A = O.value;
                                "undefined" != typeof w[A] && (e.fillStyle = w[A].colour || w[A], e.fillRect(g, y, c, x + k * L), p && "string" == typeof w[A].label && (e.font = _, e.fillStyle = C, e.textAlign = "left", e.textBaseline = "middle", e.fillText(w[A].label, g + c + f / 4, y + x / 2))), g += c + f, p && (g += a[A]), k++
                            }
                        } catch (t) {
                            T = !0, M = t
                        } finally {
                            try {
                                !E && P.return && P.return()
                            } finally {
                                if (T) throw M
                            }
                        }
                        e.closePath()
                    }
                }

                function d(t) {
                    var e = t.canvas,
                        n = t.metadata,
                        r = n.showLabels,
                        a = n.propertyName,
                        i = n.headerAngle,
                        l = s(t),
                        c = i / 180 * Math.PI;
                    e.font = o(t), t.metadata._maxHeaderWidth = 0, t.metadata._maxHeaderHeight = e.measureText("M").width;
                    var h = {};
                    if (r) {
                        var u = !0,
                            f = !1,
                            d = void 0;
                        try {
                            for (var C, v = l[Symbol.iterator](); !(u = (C = v.next()).done); u = !0) {
                                var p = C.value,
                                    g = e.measureText(p).width;
                                h[p] = Math.cos(c) * g, g > t.metadata._maxHeaderWidth && (t.metadata._maxHeaderWidth = g)
                            }
                        } catch (t) {
                            f = !0, d = t
                        } finally {
                            try {
                                !u && v.return && v.return()
                            } finally {
                                if (f) throw d
                            }
                        }
                        var y = !0,
                            b = !1,
                            m = void 0;
                        try {
                            for (var x, w = t.leaves[Symbol.iterator](); !(y = (x = w.next()).done); y = !0) {
                                var S = x.value,
                                    k = S[a],
                                    L = !0,
                                    _ = !1,
                                    E = void 0;
                                try {
                                    for (var T, M = l[Symbol.iterator](); !(L = (T = M.next()).done); L = !0) {
                                        var O = T.value;
                                        if (k[O] && "string" == typeof k[O].label) {
                                            var P = e.measureText(k[O].label).width;
                                            P > h[O] && (h[O] = P)
                                        }
                                    }
                                } catch (t) {
                                    _ = !0, E = t
                                } finally {
                                    try {
                                        !L && M.return && M.return()
                                    } finally {
                                        if (_) throw E
                                    }
                                }
                            }
                        } catch (t) {
                            b = !0, m = t
                        } finally {
                            try {
                                !y && w.return && w.return()
                            } finally {
                                if (b) throw m
                            }
                        }
                    } else {
                        var A = !0,
                            F = !1,
                            j = void 0;
                        try {
                            for (var N, R = l[Symbol.iterator](); !(A = (N = R.next()).done); A = !0) {
                                var B = N.value;
                                h[B] = 0
                            }
                        } catch (t) {
                            F = !0, j = t
                        } finally {
                            try {
                                !A && R.return && R.return()
                            } finally {
                                if (F) throw j
                            }
                        }
                    }
                    t.metadata._maxLabelWidth = h
                }

                function C(t) {
                    t(g.default, "createTree", function(t, e) {
                        var n = t.apply(void 0, a(e));
                        return n.metadata = Object.assign({}, m, n.metadata || {}), n
                    });
                    var e = p.Tree.prototype.__lookupGetter__("alignLabels");
                    p.Tree.prototype.__defineGetter__("alignLabels", function() {
                        return this.metadata.active ? this.labelAlign && this.labelAlignEnabled : e.call(this)
                    }), t(p.Prerenderer, "run", function(t, e) {
                        t.apply(this, e);
                        var n = v(e, 1),
                            r = n[0];
                        d(r), r.metadata._maxBlockSize = null
                    }), t(p.Tree, "draw", function(t, e) {
                        this.metadata.active && (this.metadata._headingDrawn = !1), t.apply(this, e)
                    }), t(p.Tree, "getBounds", function(t, e) {
                        var n = t.apply(this, e);
                        if (this.metadata.active) {
                            var r = n[0][0],
                                a = n[0][1],
                                i = n[1][0],
                                o = n[1][1],
                                s = this.metadata,
                                l = s._maxHeaderWidth,
                                c = s._maxHeaderHeight,
                                h = this.treeType,
                                u = "rectangular" === h || "diagonal" === h,
                                f = "hierarchical" === h;
                            return [
                                [r - (f ? l + c : 0), a - (u ? l + c : 0)],
                                [i, o]
                            ]
                        }
                        return n
                    }), t(p.Branch, "drawLeaf", function(t) {
                        t.call(this), this.tree.metadata.active && f.call(this, this)
                    }), t(p.Branch, "getTotalLength", function(t) {
                        var e = t.call(this);
                        return this.tree.metadata.active && (e += c(this.tree)), e
                    })
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var v = function() {
                    function t(t, e) {
                        var n = [],
                            r = !0,
                            a = !1,
                            i = void 0;
                        try {
                            for (var o, s = t[Symbol.iterator](); !(r = (o = s.next()).done) && (n.push(o.value), !e || n.length !== e); r = !0);
                        } catch (t) {
                            a = !0, i = t
                        } finally {
                            try {
                                !r && s.return && s.return()
                            } finally {
                                if (a) throw i
                            }
                        }
                        return n
                    }
                    return function(e, n) {
                        if (Array.isArray(e)) return e;
                        if (Symbol.iterator in Object(e)) return t(e, n);
                        throw new TypeError("Invalid attempt to destructure non-iterable instance")
                    }
                }();
                e.default = C;
                var p = n(1),
                    g = r(p),
                    y = p.utils.constants,
                    b = y.Angles,
                    m = {
                        _headingDrawn: !1,
                        _maxLabelWidth: {},
                        active: !0,
                        showHeaders: !0,
                        showLabels: !0,
                        blockLength: 32,
                        blockSize: null,
                        padding: 8,
                        columns: [],
                        propertyName: "data",
                        underlineHeaders: !0,
                        headerAngle: 90,
                        fillStyle: "black",
                        strokeStyle: "black",
                        lineWidth: 1,
                        font: null
                    }
            }, function(e, n) {
                e.exports = t
            }])
        })
    }, function(t, e, n) {
        ! function(e, r) {
            t.exports = r(n(3))
        }(this, function(t) {
            return function(t) {
                function e(r) {
                    if (n[r]) return n[r].exports;
                    var a = n[r] = {
                        exports: {},
                        id: r,
                        loaded: !1
                    };
                    return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
                }
                var n = {};
                return e.m = t, e.c = n, e.p = "", e(0)
            }([function(t, e, n) {
                "use strict";

                function r(t) {
                    if (Array.isArray(t)) {
                        for (var e = 0, n = Array(t.length); e < t.length; e++) n[e] = t[e];
                        return n
                    }
                    return Array.from(t)
                }

                function a(t, e) {
                    if (!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
                }

                function i(t, e) {
                    if (!t) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
                    return !e || "object" != typeof e && "function" != typeof e ? t : e
                }

                function o(t, e) {
                    if ("function" != typeof e && null !== e) throw new TypeError("Super expression must either be null or a function, not " + typeof e);
                    t.prototype = Object.create(e && e.prototype, {
                        constructor: {
                            value: t,
                            enumerable: !1,
                            writable: !0,
                            configurable: !0
                        }
                    }), e && (Object.setPrototypeOf ? Object.setPrototypeOf(t, e) : t.__proto__ = e)
                }

                function s(t) {
                    var e = t.text,
                        n = void 0 === e ? "link" : e,
                        r = t.filename,
                        a = void 0 === r ? "file" : r,
                        i = t.href,
                        o = document.createElement("a");
                    return o.appendChild(document.createTextNode(n)), o.href = i, o.download = a, o
                }

                function l(t) {
                    var e = t.tree,
                        n = t.filenames;
                    return s({
                        text: this.text,
                        filename: n.image,
                        href: e.getPngUrl()
                    })
                }

                function c(t, e) {
                    var n = t.tree,
                        r = t.filenames;
                    return s({
                        text: this.text,
                        filename: r.leafLabels,
                        href: w((e || n.root).getChildProperties("label").join("\n"))
                    })
                }

                function h(t) {
                    var e = t.tree,
                        n = t.filenames,
                        r = e.leaves.reduce(function(t, n) {
                            return n[e.clickFlag] === !0 && t.push(n.label), t
                        }, []);
                    return 0 === r.length ? null : s({
                        text: this.text,
                        filename: n.leafLabels,
                        href: w(r.join("\n"))
                    })
                }

                function u(t, e) {
                    var n = t.tree,
                        r = t.filenames;
                    return s({
                        text: this.text,
                        filename: r.newick,
                        href: w((e || n.root).getNwk())
                    })
                }

                function f() {
                    var t = document.createElement("a"),
                        e = document.createElement("img");
                    return e.src = "data:image/svg+xml;utf8,%3Csvg%20version%3D%221.1%22%20id%3D%22Layer_1%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20xmlns%3Axlink%3D%22http%3A%2F%2Fwww.w3.org%2F1999%2Fxlink%22%20x%3D%220px%22%20y%3D%220px%22%20viewBox%3D%220%200%20619.3%20166.7%22%20style%3D%22enable-background%3Anew%200%200%20619.3%20166.7%3B%22%20xml%3Aspace%3D%22preserve%22%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%09.st0%7Bfill%3A%233C7383%3B%7D%09.st1%7Bfill%3A%239BB7BF%3B%7D%3C%2Fstyle%3E%3Cg%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M139.5%2C145.8V86.4h24.1c2.5%2C0%2C4.8%2C0.5%2C6.9%2C1.6c2.1%2C1.1%2C3.9%2C2.5%2C5.4%2C4.2c1.5%2C1.8%2C2.7%2C3.7%2C3.6%2C5.9%20%20%20c0.9%2C2.2%2C1.3%2C4.4%2C1.3%2C6.7c0%2C2.4-0.4%2C4.7-1.2%2C7c-0.8%2C2.2-1.9%2C4.2-3.4%2C5.9c-1.5%2C1.7-3.2%2C3.1-5.2%2C4.1c-2%2C1-4.3%2C1.5-6.7%2C1.5h-20.5v22.4%20%20%20H139.5z%20M143.8%2C119.5H164c1.9%2C0%2C3.7-0.4%2C5.2-1.2c1.5-0.8%2C2.8-1.9%2C3.9-3.3c1.1-1.4%2C1.9-2.9%2C2.5-4.7c0.6-1.8%2C0.9-3.6%2C0.9-5.5%20%20%20c0-2-0.3-3.8-1-5.6c-0.7-1.8-1.6-3.3-2.8-4.6c-1.2-1.3-2.6-2.4-4.1-3.2c-1.6-0.8-3.2-1.2-5-1.2h-19.7V119.5z%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M224.6%2C145.8h-4.1v-24.3c0-5.4-0.9-9.5-2.7-12.1s-4.5-4-7.9-4c-1.8%2C0-3.5%2C0.3-5.2%2C1c-1.7%2C0.7-3.3%2C1.6-4.7%2C2.8%20%20%20c-1.5%2C1.2-2.7%2C2.7-3.8%2C4.3c-1.1%2C1.6-1.9%2C3.4-2.4%2C5.3v27h-4.1V84.7h4.1v28c1.8-3.4%2C4.2-6.1%2C7.3-8.1s6.5-3%2C10-3%20%20%20c2.4%2C0%2C4.4%2C0.4%2C6.1%2C1.3c1.7%2C0.9%2C3.1%2C2.2%2C4.3%2C3.9c1.1%2C1.7%2C2%2C3.7%2C2.5%2C6.1c0.5%2C2.4%2C0.8%2C5%2C0.8%2C8V145.8z%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M238.8%2C160.7c0.5%2C0%2C1.2%2C0%2C2.2-0.1c1-0.1%2C1.7-0.2%2C2.2-0.5c0.2-0.1%2C0.5-0.4%2C0.8-0.8c0.3-0.4%2C0.7-1.1%2C1.2-2.1%20%20%20c0.5-1%2C1.1-2.4%2C1.9-4.2c0.8-1.8%2C1.7-4.2%2C2.9-7.1l-19.2-43.5h4.4l17%2C39.4l15.9-39.4h4l-23.5%2C57.3c-0.8%2C2-1.9%2C3.3-3.3%2C4%20%20%20c-1.3%2C0.6-3%2C1-4.9%2C1c-0.3%2C0-0.6%2C0-0.8%2C0c-0.3%2C0-0.6%2C0-0.8-0.1V160.7z%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M318.2%2C146.7c-3%2C0-5.8-0.6-8.4-1.8c-2.6-1.2-4.8-2.8-6.6-4.9c-1.9-2.1-3.3-4.5-4.4-7.2c-1-2.7-1.6-5.6-1.6-8.6%20%20%20c0-3.1%2C0.5-6%2C1.6-8.7s2.6-5.1%2C4.5-7.2s4.1-3.7%2C6.6-4.9c2.5-1.2%2C5.3-1.8%2C8.3-1.8s5.7%2C0.6%2C8.3%2C1.8c2.6%2C1.2%2C4.8%2C2.8%2C6.7%2C4.9%20%20%20s3.4%2C4.5%2C4.5%2C7.2s1.6%2C5.6%2C1.6%2C8.7c0%2C3-0.5%2C5.9-1.6%2C8.6c-1.1%2C2.7-2.5%2C5.1-4.4%2C7.2c-1.9%2C2.1-4.1%2C3.7-6.7%2C4.9%20%20%20C323.9%2C146.1%2C321.1%2C146.7%2C318.2%2C146.7z%20M301.4%2C124.3c0%2C2.6%2C0.4%2C5%2C1.3%2C7.2c0.9%2C2.3%2C2.1%2C4.2%2C3.6%2C5.9c1.5%2C1.7%2C3.3%2C3%2C5.3%2C4%20%20%20c2%2C1%2C4.2%2C1.5%2C6.5%2C1.5s4.5-0.5%2C6.5-1.5c2-1%2C3.8-2.3%2C5.3-4.1c1.5-1.7%2C2.7-3.7%2C3.6-6s1.4-4.7%2C1.4-7.3c0-2.6-0.5-5-1.4-7.2%20%20%20c-0.9-2.3-2.1-4.2-3.6-5.9c-1.5-1.7-3.3-3.1-5.3-4.1c-2-1-4.2-1.5-6.5-1.5c-2.3%2C0-4.4%2C0.5-6.4%2C1.5c-2%2C1-3.8%2C2.4-5.4%2C4.1%20%20%20c-1.5%2C1.7-2.8%2C3.8-3.6%2C6.1C301.8%2C119.3%2C301.4%2C121.7%2C301.4%2C124.3z%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M405.7%2C146.7c-2.1%2C0-4-0.3-5.8-1c-1.8-0.7-3.3-1.7-4.6-2.9c-1.3-1.2-2.3-2.7-3.1-4.4s-1.1-3.5-1.1-5.4%20%20%20c0-2.1%2C0.4-3.9%2C1.3-5.6c0.9-1.7%2C2.1-3.1%2C3.8-4.4c1.6-1.2%2C3.6-2.2%2C5.8-2.8s4.7-1%2C7.4-1c2%2C0%2C4%2C0.2%2C6%2C0.5c2%2C0.4%2C3.8%2C0.9%2C5.4%2C1.5v-3%20%20%20c0-3.2-0.9-5.8-2.7-7.6c-1.8-1.8-4.4-2.7-7.8-2.7c-2.3%2C0-4.6%2C0.4-6.8%2C1.3c-2.2%2C0.9-4.5%2C2.1-6.9%2C3.7l-2.8-5.9%20%20%20c5.6-3.8%2C11.3-5.7%2C17.3-5.7c5.9%2C0%2C10.6%2C1.5%2C13.9%2C4.6c3.3%2C3.1%2C5%2C7.5%2C5%2C13.2V135c0%2C1.1%2C0.2%2C1.8%2C0.6%2C2.3c0.4%2C0.4%2C1%2C0.7%2C2%2C0.8v7.9%20%20%20c-0.9%2C0.2-1.7%2C0.3-2.4%2C0.3c-0.7%2C0.1-1.4%2C0.1-2%2C0.1c-1.8-0.1-3.1-0.6-4-1.4c-0.9-0.8-1.5-2-1.7-3.3l-0.2-2.8%20%20%20c-1.9%2C2.6-4.3%2C4.5-7.1%2C5.9C412%2C146%2C408.9%2C146.7%2C405.7%2C146.7z%20M408.2%2C139.9c2.2%2C0%2C4.3-0.4%2C6.2-1.2c2-0.8%2C3.5-1.9%2C4.6-3.4%20%20%20c1.2-1%2C1.7-2.1%2C1.7-3.2v-5.8c-1.5-0.6-3.2-1.1-4.9-1.4s-3.4-0.5-5.1-0.5c-3.2%2C0-5.9%2C0.7-8%2C2.1s-3.1%2C3.3-3.1%2C5.7%20%20%20c0%2C2.2%2C0.8%2C4%2C2.4%2C5.5C403.7%2C139.2%2C405.7%2C139.9%2C408.2%2C139.9z%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M479.7%2C145.8h-9.1v-24.5c0-4.1-0.7-7.1-2-9c-1.3-1.9-3.2-2.8-5.7-2.8c-1.3%2C0-2.7%2C0.3-4%2C0.8%20%20%20c-1.3%2C0.5-2.6%2C1.2-3.8%2C2.1c-1.2%2C0.9-2.2%2C2-3.1%2C3.3s-1.6%2C2.6-2.1%2C4.1v26h-9.1V102h8.3v8.8c1.7-3%2C4-5.3%2C7.2-7%20%20%20c3.1-1.7%2C6.6-2.6%2C10.4-2.6c2.6%2C0%2C4.7%2C0.5%2C6.4%2C1.4c1.7%2C0.9%2C3%2C2.2%2C4%2C3.9c1%2C1.6%2C1.6%2C3.5%2C2%2C5.7c0.4%2C2.1%2C0.6%2C4.4%2C0.6%2C6.8V145.8z%22%2F%3E%09%3Cpolygon%20class%3D%22st0%22%20points%3D%22501.3%2C145.8%20484.8%2C102%20494.2%2C102%20506.5%2C138.1%20519%2C102%20527.6%2C102%20511.1%2C145.8%20%20%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M544.3%2C146.7c-2.1%2C0-4-0.3-5.8-1c-1.8-0.7-3.3-1.7-4.6-2.9c-1.3-1.2-2.3-2.7-3.1-4.4s-1.1-3.5-1.1-5.4%20%20%20c0-2.1%2C0.4-3.9%2C1.3-5.6c0.9-1.7%2C2.1-3.1%2C3.8-4.4c1.6-1.2%2C3.6-2.2%2C5.8-2.8c2.2-0.7%2C4.7-1%2C7.4-1c2%2C0%2C4%2C0.2%2C6%2C0.5%20%20%20c2%2C0.4%2C3.8%2C0.9%2C5.4%2C1.5v-3c0-3.2-0.9-5.8-2.7-7.6c-1.8-1.8-4.4-2.7-7.8-2.7c-2.3%2C0-4.6%2C0.4-6.8%2C1.3c-2.2%2C0.9-4.5%2C2.1-6.9%2C3.7%20%20%20l-2.8-5.9c5.6-3.8%2C11.3-5.7%2C17.3-5.7c5.9%2C0%2C10.6%2C1.5%2C13.9%2C4.6c3.3%2C3.1%2C5%2C7.5%2C5%2C13.2V135c0%2C1.1%2C0.2%2C1.8%2C0.6%2C2.3c0.4%2C0.4%2C1%2C0.7%2C2%2C0.8%20%20%20v7.9c-0.9%2C0.2-1.7%2C0.3-2.4%2C0.3c-0.7%2C0.1-1.4%2C0.1-2%2C0.1c-1.8-0.1-3.1-0.6-4-1.4c-0.9-0.8-1.5-2-1.7-3.3l-0.2-2.8%20%20%20c-1.9%2C2.6-4.3%2C4.5-7.1%2C5.9C550.6%2C146%2C547.6%2C146.7%2C544.3%2C146.7z%20M546.8%2C139.9c2.2%2C0%2C4.3-0.4%2C6.2-1.2c2-0.8%2C3.5-1.9%2C4.6-3.4%20%20%20c1.2-1%2C1.7-2.1%2C1.7-3.2v-5.8c-1.5-0.6-3.2-1.1-4.9-1.4c-1.7-0.3-3.4-0.5-5.1-0.5c-3.2%2C0-5.9%2C0.7-8%2C2.1s-3.1%2C3.3-3.1%2C5.7%20%20%20c0%2C2.2%2C0.8%2C4%2C2.4%2C5.5C542.3%2C139.2%2C544.3%2C139.9%2C546.8%2C139.9z%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M595.7%2C146.7c-1.8%2C0-3.5-0.1-5.3-0.4c-1.8-0.3-3.6-0.7-5.3-1.2c-1.7-0.5-3.4-1.2-5-1.9s-3-1.6-4.2-2.6l3.8-6.2%20%20%20c5.3%2C3.7%2C10.5%2C5.6%2C15.8%2C5.6c2.8%2C0%2C4.9-0.5%2C6.5-1.6c1.6-1.1%2C2.4-2.6%2C2.4-4.5c0-1.8-0.9-3.2-2.7-4.1c-1.8-0.9-4.6-1.8-8.5-2.7%20%20%20c-2.7-0.7-5-1.4-6.9-2.1c-1.9-0.7-3.5-1.5-4.7-2.3c-1.2-0.9-2.1-1.9-2.6-3.1c-0.6-1.2-0.8-2.6-0.8-4.3c0-2.2%2C0.4-4.2%2C1.3-5.9%20%20%20c0.9-1.7%2C2.1-3.2%2C3.6-4.4c1.5-1.2%2C3.3-2.1%2C5.4-2.7c2.1-0.6%2C4.3-0.9%2C6.6-0.9c3.1%2C0%2C6.2%2C0.5%2C9.1%2C1.5c2.9%2C1%2C5.5%2C2.4%2C7.8%2C4.1l-3.9%2C5.6%20%20%20c-4.1-3.1-8.5-4.7-13.2-4.7c-2.3%2C0-4.3%2C0.5-5.9%2C1.5c-1.6%2C1-2.4%2C2.5-2.4%2C4.6c0%2C0.9%2C0.2%2C1.6%2C0.5%2C2.3c0.3%2C0.6%2C0.9%2C1.1%2C1.6%2C1.6%20%20%20c0.7%2C0.4%2C1.7%2C0.9%2C2.9%2C1.2c1.2%2C0.4%2C2.7%2C0.8%2C4.5%2C1.2c3%2C0.7%2C5.5%2C1.5%2C7.7%2C2.2c2.1%2C0.7%2C3.9%2C1.6%2C5.3%2C2.6c1.4%2C1%2C2.4%2C2.1%2C3.1%2C3.4%20%20%20c0.7%2C1.3%2C1%2C2.9%2C1%2C4.7c0%2C2.1-0.4%2C3.9-1.2%2C5.6c-0.8%2C1.7-2%2C3.1-3.5%2C4.3c-1.5%2C1.2-3.4%2C2.1-5.5%2C2.7C600.8%2C146.4%2C598.3%2C146.7%2C595.7%2C146.7%20%20%20z%22%2F%3E%09%3Cpath%20class%3D%22st0%22%20d%3D%22M345.5%2C124c0-3.1%2C0.5-6%2C1.6-8.7c1.1-2.7%2C2.6-5.1%2C4.6-7.2c2-2.1%2C4.4-3.7%2C7.1-4.9c2.8-1.2%2C5.9-1.8%2C9.4-1.8%20%20%20c4.5%2C0%2C8.4%2C1%2C11.7%2C3c3.3%2C2%2C5.7%2C4.6%2C7.3%2C7.9l-8.9%2C2.8c-1.1-1.8-2.5-3.3-4.3-4.3c-1.8-1-3.8-1.5-5.9-1.5c-1.8%2C0-3.6%2C0.4-5.1%2C1.1%20%20%20c-1.6%2C0.7-3%2C1.7-4.1%2C3c-1.2%2C1.3-2.1%2C2.9-2.8%2C4.6c-0.7%2C1.8-1%2C3.8-1%2C5.9c0%2C2.1%2C0.3%2C4.1%2C1%2C5.9c0.7%2C1.8%2C1.6%2C3.4%2C2.8%2C4.7%20%20%20c1.2%2C1.3%2C2.6%2C2.4%2C4.2%2C3.1c1.6%2C0.8%2C3.3%2C1.1%2C5.1%2C1.1c1.1%2C0%2C2.2-0.2%2C3.3-0.5c1.1-0.3%2C2.1-0.7%2C3-1.3c0.9-0.6%2C1.7-1.2%2C2.4-1.9%20%20%20c0.7-0.7%2C1.2-1.5%2C1.5-2.3l9%2C2.7c-1.4%2C3.3-3.9%2C6-7.3%2C8.1c-3.4%2C2.1-7.4%2C3.1-12%2C3.1c-3.4%2C0-6.5-0.6-9.3-1.8c-2.8-1.2-5.2-2.9-7.1-5%20%20%20c-2-2.1-3.5-4.5-4.6-7.2C346.1%2C129.9%2C345.5%2C127%2C345.5%2C124z%22%2F%3E%09%3Cpolygon%20class%3D%22st0%22%20points%3D%22280.8%2C84.7%20285.1%2C84.7%20285.1%2C146.3%20280.8%2C146.3%20%20%22%2F%3E%09%3Cpath%20class%3D%22st1%22%20d%3D%22M110.6%2C105.2c0-0.2%2C0.1-0.3%2C0.1-0.5c0-0.1%2C0-0.3%2C0.1-0.4c0-0.2%2C0-0.4%2C0.1-0.6c0-0.2%2C0-0.4%2C0-0.6%20%20%20c0-0.1%2C0-0.2%2C0-0.4c0-0.1%2C0-0.3%2C0-0.4l0-0.3c0-0.1%2C0-0.3%2C0-0.4c0-0.2%2C0-0.3%2C0-0.4l0-0.2c0-0.2%2C0-0.4-0.1-0.5l0-0.2%20%20%20c0-0.2-0.1-0.4-0.1-0.6l0-0.1c0-0.2-0.1-0.3-0.1-0.5l-0.1-0.2c0-0.1-0.1-0.3-0.1-0.4l-0.1-0.2c0-0.1-0.1-0.3-0.1-0.4%20%20%20c0-0.1-0.1-0.2-0.1-0.3c0-0.1-0.1-0.2-0.1-0.4l-0.1-0.2c-0.1-0.2-0.1-0.4-0.2-0.6c-0.1-0.2-0.2-0.4-0.3-0.6l-0.1-0.1%20%20%20c-0.1-0.2-0.2-0.3-0.2-0.5l-0.1-0.2c-0.1-0.2-0.2-0.3-0.3-0.5l0-0.1c-0.1-0.2-0.2-0.4-0.3-0.5c-0.1-0.2-0.2-0.4-0.4-0.6l-0.1-0.1%20%20%20c-0.1-0.2-0.2-0.3-0.4-0.5c-0.1-0.2-0.3-0.4-0.4-0.5l0%2C0c-0.1-0.2-0.3-0.3-0.4-0.5c-0.2-0.2-0.3-0.3-0.5-0.5%20%20%20c-0.2-0.2-0.3-0.3-0.5-0.5c-0.2-0.2-0.4-0.3-0.5-0.5c-0.2-0.2-0.5-0.4-0.8-0.6l-0.4-0.2c-0.2-0.1-0.4-0.2-0.5-0.3%20%20%20c-0.2-0.1-0.4-0.3-0.7-0.4l-0.1-0.1c-0.2-0.1-0.4-0.2-0.6-0.3c-0.2-0.1-0.4-0.2-0.7-0.3l-0.1%2C0c-3.1-1.3-5.9-3-8.4-5.1%20%20%20c-3.1-2.7-5.6-5.9-7.4-9.5l0%2C0c-1.4-2.9-2.4-6.1-2.9-9.3c0-0.1%2C0-0.3-0.1-0.4c-0.8-5.1-4.2-9.6-9.3-11.7%20%20%20c-5.1-2.1-10.7-1.2-14.8%2C1.9c-0.2%2C0.2-0.4%2C0.3-0.6%2C0.4c-1.9%2C1.6-3.5%2C3.6-4.4%2C6c-1%2C2.4-1.3%2C4.9-1%2C7.4l0%2C0c0%2C0.2%2C0.1%2C0.5%2C0.1%2C0.7l0%2C0%20%20%20c0.8%2C5.1%2C4.2%2C9.6%2C9.3%2C11.7l0%2C0c2.2%2C0.9%2C4.2%2C2%2C6.1%2C3.3c0.4%2C0.3%2C0.8%2C0.6%2C1.2%2C0.9l0%2C0c0.4%2C0.3%2C0.7%2C0.6%2C1.1%2C0.9l0%2C0l0%2C0l0%2C0%20%20%20c3.1%2C2.7%2C5.6%2C5.9%2C7.3%2C9.5c1.4%2C2.8%2C2.4%2C5.8%2C2.8%2C8.9l0%2C0.1c0%2C0.3%2C0.1%2C0.5%2C0.1%2C0.8c0%2C0.3%2C0.1%2C0.6%2C0.2%2C0.9c0.1%2C0.2%2C0.1%2C0.5%2C0.2%2C0.7%20%20%20l0.1%2C0.2l0%2C0c0.1%2C0.2%2C0.1%2C0.4%2C0.2%2C0.6c0.1%2C0.2%2C0.2%2C0.5%2C0.3%2C0.7l0.1%2C0.3l0%2C0c0.1%2C0.2%2C0.2%2C0.4%2C0.3%2C0.6c0.1%2C0.3%2C0.3%2C0.5%2C0.4%2C0.8l0%2C0%20%20%20c0.1%2C0.2%2C0.3%2C0.5%2C0.4%2C0.7c0.2%2C0.2%2C0.3%2C0.5%2C0.5%2C0.7c0.2%2C0.2%2C0.3%2C0.5%2C0.5%2C0.7c0.1%2C0.1%2C0.2%2C0.3%2C0.4%2C0.4c0.2%2C0.2%2C0.4%2C0.5%2C0.6%2C0.7%20%20%20c0.2%2C0.2%2C0.3%2C0.3%2C0.5%2C0.5c0.1%2C0.1%2C0.3%2C0.2%2C0.4%2C0.4c0.2%2C0.2%2C0.4%2C0.4%2C0.6%2C0.5c0.2%2C0.2%2C0.5%2C0.3%2C0.7%2C0.5c0.2%2C0.2%2C0.5%2C0.3%2C0.7%2C0.5%20%20%20c0.1%2C0.1%2C0.3%2C0.2%2C0.5%2C0.3l0.4%2C0.2l0.3%2C0.1c0.1%2C0.1%2C0.3%2C0.1%2C0.4%2C0.2c0.2%2C0.1%2C0.4%2C0.2%2C0.7%2C0.3l0.1%2C0c0.2%2C0.1%2C0.4%2C0.2%2C0.7%2C0.3%20%20%20c7.6%2C2.7%2C16-1.1%2C19.1-8.6C110.1%2C107%2C110.4%2C106.1%2C110.6%2C105.2z%22%2F%3E%09%3Cpath%20class%3D%22st1%22%20d%3D%22M12.3%2C84.1c0.1%2C0.1%2C0.3%2C0.2%2C0.4%2C0.3c0.1%2C0.1%2C0.2%2C0.2%2C0.3%2C0.3c0.2%2C0.1%2C0.3%2C0.2%2C0.5%2C0.3c0.2%2C0.1%2C0.3%2C0.2%2C0.5%2C0.4%20%20%20l0.3%2C0.2l0.3%2C0.2l0.2%2C0.1c0.1%2C0.1%2C0.2%2C0.1%2C0.4%2C0.2c0.1%2C0.1%2C0.3%2C0.1%2C0.4%2C0.2l0.2%2C0.1c0.2%2C0.1%2C0.3%2C0.1%2C0.5%2C0.2l0.1%2C0.1%20%20%20c0.2%2C0.1%2C0.4%2C0.1%2C0.6%2C0.2l0.1%2C0c0.2%2C0.1%2C0.3%2C0.1%2C0.5%2C0.2l0.2%2C0.1c0.1%2C0%2C0.3%2C0.1%2C0.4%2C0.1l0.2%2C0.1c0.1%2C0%2C0.3%2C0.1%2C0.4%2C0.1%20%20%20c0.1%2C0%2C0.2%2C0.1%2C0.3%2C0.1c0.1%2C0%2C0.2%2C0.1%2C0.4%2C0.1l0.2%2C0c0.2%2C0%2C0.4%2C0.1%2C0.6%2C0.1c0.2%2C0%2C0.4%2C0.1%2C0.6%2C0.1l0.1%2C0c0.2%2C0%2C0.4%2C0%2C0.5%2C0l0.2%2C0%20%20%20c0.2%2C0%2C0.4%2C0%2C0.6%2C0l0.1%2C0c0.2%2C0%2C0.4%2C0%2C0.6%2C0c0.2%2C0%2C0.4%2C0%2C0.7%2C0l0.1%2C0c0.2%2C0%2C0.4%2C0%2C0.6-0.1c0.2%2C0%2C0.4-0.1%2C0.7-0.1l0.1%2C0%20%20%20c0.2%2C0%2C0.4-0.1%2C0.6-0.1c0.2-0.1%2C0.5-0.1%2C0.7-0.2c0.2-0.1%2C0.4-0.1%2C0.7-0.2c0.2-0.1%2C0.4-0.2%2C0.7-0.2c0.3-0.1%2C0.6-0.2%2C0.9-0.4%20%20%20c0.1-0.1%2C0.3-0.1%2C0.4-0.2c0.2-0.1%2C0.4-0.2%2C0.6-0.3c0.2-0.1%2C0.4-0.2%2C0.6-0.4l0.1-0.1c0.2-0.1%2C0.4-0.2%2C0.6-0.4%20%20%20c0.2-0.1%2C0.4-0.3%2C0.6-0.4l0.1%2C0c2.7-2.1%2C5.6-3.7%2C8.6-4.7c3.9-1.4%2C7.9-1.9%2C11.9-1.7l0%2C0c3.3%2C0.2%2C6.5%2C0.9%2C9.5%2C2.1%20%20%20c0.1%2C0.1%2C0.3%2C0.1%2C0.4%2C0.2c4.8%2C1.8%2C10.4%2C1.2%2C14.8-2.2c4.4-3.4%2C6.4-8.7%2C5.8-13.8c0-0.2-0.1-0.5-0.1-0.7c-0.4-2.4-1.4-4.8-3-6.9%20%20%20c-1.6-2.1-3.6-3.6-5.9-4.6l0%2C0c-0.2-0.1-0.5-0.2-0.7-0.3l0%2C0c-4.8-1.8-10.4-1.1-14.7%2C2.2l0%2C0c-1.9%2C1.5-3.8%2C2.7-5.9%2C3.6%20%20%20c-0.5%2C0.2-0.9%2C0.4-1.4%2C0.6l0%2C0c-0.4%2C0.2-0.9%2C0.3-1.3%2C0.5l0%2C0l0%2C0l0%2C0c-3.9%2C1.3-7.9%2C1.9-11.9%2C1.6c-3.1-0.2-6.2-0.9-9.2-2l0%2C0%20%20%20c-0.3-0.1-0.5-0.2-0.8-0.3c-0.3-0.1-0.5-0.2-0.8-0.3c-0.2-0.1-0.5-0.1-0.7-0.2l-0.2-0.1l0%2C0c-0.2-0.1-0.4-0.1-0.7-0.1%20%20%20c-0.3%2C0-0.5-0.1-0.8-0.1l-0.3%2C0l0%2C0c-0.2%2C0-0.5%2C0-0.7-0.1c-0.3%2C0-0.6%2C0-0.8%2C0l0%2C0c-0.3%2C0-0.6%2C0-0.9%2C0c-0.3%2C0-0.6%2C0-0.9%2C0.1%20%20%20c-0.3%2C0-0.6%2C0.1-0.9%2C0.1c-0.2%2C0-0.4%2C0.1-0.5%2C0.1c-0.3%2C0.1-0.6%2C0.1-0.9%2C0.2c-0.2%2C0.1-0.5%2C0.1-0.7%2C0.2c-0.2%2C0.1-0.3%2C0.1-0.5%2C0.2%20%20%20c-0.3%2C0.1-0.5%2C0.2-0.8%2C0.3c-0.3%2C0.1-0.5%2C0.2-0.8%2C0.3c-0.3%2C0.1-0.5%2C0.3-0.8%2C0.4c-0.2%2C0.1-0.3%2C0.2-0.5%2C0.3c-0.1%2C0.1-0.2%2C0.1-0.4%2C0.2%20%20%20L14%2C59.9c-0.1%2C0.1-0.3%2C0.2-0.4%2C0.3c-0.2%2C0.1-0.4%2C0.3-0.6%2C0.4l-0.1%2C0c-0.2%2C0.1-0.4%2C0.3-0.6%2C0.5c-6.1%2C5.3-7.1%2C14.5-2%2C20.9%20%20%20C10.9%2C82.8%2C11.6%2C83.5%2C12.3%2C84.1z%22%2F%3E%09%3Cpath%20class%3D%22st1%22%20d%3D%22M72.6%2C80.7c0.2-0.1%2C0.3-0.1%2C0.5-0.2c0.1-0.1%2C0.3-0.1%2C0.4-0.2c0.2-0.1%2C0.4-0.2%2C0.5-0.2c0.2-0.1%2C0.4-0.2%2C0.6-0.3%20%20%20c0.1-0.1%2C0.2-0.1%2C0.3-0.2c0.1-0.1%2C0.2-0.1%2C0.3-0.2l0.2-0.1c0.1-0.1%2C0.2-0.1%2C0.4-0.2c0.1-0.1%2C0.2-0.2%2C0.4-0.2l0.2-0.1%20%20%20c0.1-0.1%2C0.3-0.2%2C0.4-0.3l0.1-0.1c0.2-0.1%2C0.3-0.3%2C0.5-0.4l0%2C0c0.1-0.1%2C0.3-0.2%2C0.4-0.3l0.2-0.2c0.1-0.1%2C0.2-0.2%2C0.3-0.3l0.2-0.2%20%20%20l0.3-0.3l0.2-0.3l0.2-0.3l0.1-0.2c0.1-0.1%2C0.3-0.3%2C0.4-0.5c0.1-0.2%2C0.2-0.3%2C0.4-0.5l0.1-0.1c0.1-0.1%2C0.2-0.3%2C0.3-0.4l0.1-0.1%20%20%20c0.1-0.2%2C0.2-0.3%2C0.3-0.5l0-0.1c0.1-0.2%2C0.2-0.4%2C0.3-0.6c0.1-0.2%2C0.2-0.4%2C0.3-0.6l0-0.1c0.1-0.2%2C0.2-0.4%2C0.2-0.6%20%20%20c0.1-0.2%2C0.2-0.4%2C0.2-0.6l0-0.1c0.1-0.2%2C0.1-0.4%2C0.2-0.6c0.1-0.2%2C0.1-0.4%2C0.2-0.7c0.1-0.2%2C0.1-0.5%2C0.1-0.7c0-0.2%2C0.1-0.5%2C0.1-0.7%20%20%20c0-0.3%2C0.1-0.6%2C0.1-1c0-0.1%2C0-0.3%2C0-0.4c0-0.2%2C0-0.4%2C0-0.6c0-0.3%2C0-0.5%2C0-0.8l0-0.2c0-0.2%2C0-0.4%2C0-0.7c0-0.2%2C0-0.5-0.1-0.7l0-0.1%20%20%20c-0.5-3.4-0.4-6.7%2C0.2-9.8c0.7-4%2C2.3-7.8%2C4.5-11.2l0%2C0c1.8-2.7%2C4-5.2%2C6.6-7.2c0.1-0.1%2C0.2-0.2%2C0.3-0.3c4-3.3%2C6.2-8.5%2C5.4-13.9%20%20%20c-0.8-5.5-4.4-9.8-9.1-11.9c-0.2-0.1-0.5-0.2-0.7-0.3c-2.3-0.9-4.8-1.2-7.4-0.8c-2.6%2C0.4-4.9%2C1.4-6.9%2C2.8l0%2C0%20%20%20c-0.2%2C0.2-0.4%2C0.3-0.6%2C0.5l0%2C0c-3.9%2C3.3-6.2%2C8.4-5.4%2C13.9l0%2C0c0.3%2C2.3%2C0.4%2C4.7%2C0.2%2C6.9c0%2C0.5-0.1%2C1-0.2%2C1.5l0%2C0%20%20%20c-0.1%2C0.5-0.1%2C0.9-0.2%2C1.4l0%2C0l0%2C0l0%2C0c-0.7%2C4-2.3%2C7.8-4.5%2C11.1c-1.7%2C2.6-3.8%2C5-6.3%2C7l0%2C0c-0.2%2C0.2-0.4%2C0.3-0.6%2C0.5%20%20%20c-0.2%2C0.2-0.4%2C0.4-0.7%2C0.6c-0.2%2C0.2-0.4%2C0.3-0.5%2C0.5l-0.2%2C0.2l0%2C0c-0.2%2C0.2-0.3%2C0.3-0.4%2C0.5c-0.2%2C0.2-0.3%2C0.4-0.5%2C0.6l-0.2%2C0.3l0%2C0%20%20%20c-0.1%2C0.2-0.3%2C0.4-0.4%2C0.6c-0.2%2C0.2-0.3%2C0.5-0.5%2C0.7l0%2C0c-0.1%2C0.2-0.3%2C0.5-0.4%2C0.7c-0.1%2C0.3-0.3%2C0.5-0.4%2C0.8%20%20%20c-0.1%2C0.3-0.2%2C0.5-0.3%2C0.8c-0.1%2C0.2-0.1%2C0.3-0.2%2C0.5c-0.1%2C0.3-0.2%2C0.6-0.3%2C0.9c-0.1%2C0.2-0.1%2C0.5-0.2%2C0.7c0%2C0.2-0.1%2C0.3-0.1%2C0.5%20%20%20c0%2C0.3-0.1%2C0.6-0.1%2C0.8c0%2C0.3-0.1%2C0.6-0.1%2C0.8c0%2C0.3%2C0%2C0.6%2C0%2C0.9c0%2C0.2%2C0%2C0.4%2C0%2C0.5c0%2C0.1%2C0%2C0.3%2C0%2C0.4l0%2C0.3c0%2C0.2%2C0%2C0.3%2C0%2C0.5%20%20%20c0%2C0.2%2C0%2C0.5%2C0.1%2C0.7l0%2C0.1c0%2C0.2%2C0.1%2C0.5%2C0.1%2C0.7c1.5%2C7.9%2C9%2C13.3%2C17.1%2C12.2C70.7%2C81.3%2C71.7%2C81%2C72.6%2C80.7z%22%2F%3E%09%3Ccircle%20class%3D%22st0%22%20cx%3D%2222.5%22%20cy%3D%2272.6%22%20r%3D%2215.2%22%2F%3E%09%3Ccircle%20class%3D%22st0%22%20cx%3D%2295.5%22%20cy%3D%22102.1%22%20r%3D%2215.2%22%2F%3E%09%3Ccircle%20class%3D%22st0%22%20cx%3D%2284.6%22%20cy%3D%2223.9%22%20r%3D%2215.2%22%2F%3E%3C%2Fg%3E%3C%2Fsvg%3E",
                        e.style = "width: 124px; margin: 4px auto 0", t.appendChild(e), t.title = "About Phylocanvas...", t.href = "http://phylocanvas.org/", t.target = "_blank", t
                }

                function d(t) {
                    if (2 === t.button) {
                        t.preventDefault();
                        var e = this.getNodeAtMousePosition(t);
                        this.contextMenu.open(t.clientX, t.clientY, e && e.interactive ? e : null), this.contextMenu.closed = !1, this.tooltip.close()
                    }
                }

                function C(t) {
                    this.contextMenu.cleanup(), t.call(this)
                }

                function v(t) {
                    t(this, "createTree", function(e, n) {
                        var a = e.apply(void 0, r(n)),
                            i = p(n, 2),
                            o = i[1],
                            s = void 0 === o ? {} : o;
                        return s.contextMenu !== !1 && (a.contextMenu = new _(a, s.contextMenu), a.addListener("contextmenu", d.bind(a)), t(a, "cleanup", C)), a
                    }), this.ContextMenu = _
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                }), e.DEFAULT_BRANCH_MENU_ITEMS = e.DEFAULT_MENU_ITEMS = void 0;
                var p = function() {
                        function t(t, e) {
                            var n = [],
                                r = !0,
                                a = !1,
                                i = void 0;
                            try {
                                for (var o, s = t[Symbol.iterator](); !(r = (o = s.next()).done) && (n.push(o.value), !e || n.length !== e); r = !0);
                            } catch (t) {
                                a = !0, i = t
                            } finally {
                                try {
                                    !r && s.return && s.return()
                                } finally {
                                    if (a) throw i
                                }
                            }
                            return n
                        }
                        return function(e, n) {
                            if (Array.isArray(e)) return e;
                            if (Symbol.iterator in Object(e)) return t(e, n);
                            throw new TypeError("Invalid attempt to destructure non-iterable instance")
                        }
                    }(),
                    g = function() {
                        function t(t, e) {
                            for (var n = 0; n < e.length; n++) {
                                var r = e[n];
                                r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(t, r.key, r)
                            }
                        }
                        return function(e, n, r) {
                            return n && t(e.prototype, n), r && t(e, r), e
                        }
                    }();
                e.default = v;
                var y = n(1),
                    b = y.utils.events,
                    m = b.createHandler,
                    x = b.preventDefault,
                    w = y.utils.dom.createBlobUrl,
                    S = e.DEFAULT_MENU_ITEMS = [
                        [{
                            text: "Show/Hide Labels",
                            handler: "toggleLabels"
                        }, {
                            text: "Align/Realign Labels",
                            handler: function(t) {
                                t.alignLabels = !t.alignLabels
                            }
                        }],
                        [{
                            text: "Fit in Panel",
                            handler: function(t) {
                                t.fitInPanel()
                            }
                        }, {
                            text: "Redraw Original Tree",
                            handler: "redrawOriginalTree"
                        }, {
                            text: "Expand All",
                            handler: function(t) {
                                var e = !0,
                                    n = !1,
                                    r = void 0;
                                try {
                                    for (var a, i = Object.keys(t.branches)[Symbol.iterator](); !(e = (a = i.next()).done); e = !0) {
                                        var o = a.value;
                                        t.branches[o].expand()
                                    }
                                } catch (t) {
                                    n = !0, r = t
                                } finally {
                                    try {
                                        !e && i.return && i.return()
                                    } finally {
                                        if (n) throw r
                                    }
                                }
                            }
                        }],
                        [{
                            text: "Export Leaf Labels",
                            element: c
                        }, {
                            text: "Export Selected Labels",
                            element: h
                        }, {
                            text: "Export as Newick File",
                            element: u
                        }, {
                            text: "Export as Image",
                            element: l
                        }],
                        [{
                            element: f
                        }]
                    ],
                    k = e.DEFAULT_BRANCH_MENU_ITEMS = [
                        [{
                            text: "Collapse/Expand Subtree",
                            handler: function(t) {
                                t.toggleCollapsed(), t.tree.draw()
                            }
                        }, {
                            text: "Invert Subtree",
                            handler: "rotate"
                        }],
                        [{
                            text: "Redraw Subtree",
                            handler: "redrawTreeFromBranch"
                        }],
                        [{
                            text: "Export Subtree Leaf Labels",
                            element: c
                        }, {
                            text: "Export Subtree as Newick File",
                            element: u
                        }],
                        [{
                            element: f
                        }]
                    ],
                    L = {
                        image: "phylocanvas.png",
                        leafLabels: "phylocanvas-leaf-labels.txt",
                        newick: "phylocanvas.nwk"
                    },
                    _ = function(t) {
                        function e(t) {
                            var r = arguments.length > 1 && void 0 !== arguments[1] ? arguments[1] : {},
                                o = r.menuItems,
                                s = void 0 === o ? S : o,
                                l = r.branchMenuItems,
                                c = void 0 === l ? k : l,
                                h = r.unstyled,
                                u = void 0 !== h && h,
                                f = r.className,
                                d = void 0 === f ? "" : f,
                                C = r.parent,
                                v = r.filenames,
                                p = void 0 === v ? L : v;
                            a(this, e);
                            var g = i(this, (e.__proto__ || Object.getPrototypeOf(e)).call(this, t, {
                                className: ("phylocanvas-context-menu " + d).trim(),
                                element: document.createElement("ul"),
                                parent: C
                            }));
                            return g.menuItems = s, g.branchMenuItems = c, g.filenames = p, u || n(2), g.element.addEventListener("click", function(t) {
                                return t.stopPropagation()
                            }), g
                        }
                        return o(e, t), g(e, [{
                            key: "createSublist",
                            value: function(t, e) {
                                var n = document.createElement("ul"),
                                    r = !0,
                                    a = !1,
                                    i = void 0;
                                try {
                                    for (var o, s = t[Symbol.iterator](); !(r = (o = s.next()).done); r = !0) {
                                        var l = o.value,
                                            c = null;
                                        if (l.element) {
                                            var h = l.element(this, e);
                                            h && (c = document.createElement("li"), c.appendChild(h))
                                        } else c = document.createElement("li"), c.appendChild(document.createTextNode(l.text)), c.addEventListener("click", m(e || this.tree, l.handler));
                                        c && (c.addEventListener("click", m(this, "close")), c.addEventListener("contextmenu", x), n.appendChild(c))
                                    }
                                } catch (t) {
                                    a = !0, i = t
                                } finally {
                                    try {
                                        !r && s.return && s.return()
                                    } finally {
                                        if (a) throw i
                                    }
                                }
                                n.hasChildNodes() && this.element.appendChild(n)
                            }
                        }, {
                            key: "createContent",
                            value: function(t) {
                                var e = t && t.children.length ? this.branchMenuItems : this.menuItems,
                                    n = !0,
                                    r = !1,
                                    a = void 0;
                                try {
                                    for (var i, o = e[Symbol.iterator](); !(n = (i = o.next()).done); n = !0) {
                                        var s = i.value;
                                        this.createSublist(s, t)
                                    }
                                } catch (t) {
                                    r = !0, a = t
                                } finally {
                                    try {
                                        !n && o.return && o.return()
                                    } finally {
                                        if (r) throw a
                                    }
                                }
                                document.body.addEventListener("click", m(this, "close"))
                            }
                        }, {
                            key: "cleanup",
                            value: function() {
                                this.element.parentNode.removeChild(this.element)
                            }
                        }]), e
                    }(y.Tooltip)
            }, function(e, n) {
                e.exports = t
            }, function(t, e, n) {
                var r = n(3);
                "string" == typeof r && (r = [
                    [t.id, r, ""]
                ]), n(5)(r, {}), r.locals && (t.exports = r.locals)
            }, function(t, e, n) {
                e = t.exports = n(4)(), e.push([t.id, ".phylocanvas-context-menu,.phylocanvas-context-menu ul{list-style:outside none none;margin:0}.phylocanvas-context-menu{background:#fff;border-radius:2px;box-shadow:0 2px 2px 0 rgba(0,0,0,.14),0 3px 1px -2px rgba(0,0,0,.2),0 1px 5px 0 rgba(0,0,0,.12);letter-spacing:0;list-style:outside none none;min-width:124px;padding:8px 0}.phylocanvas-context-menu ul{padding:0}.phylocanvas-context-menu ul+ul{border-top:1px solid #e0e0e0;margin-top:8px;padding-top:8px}.phylocanvas-context-menu li{padding:0 16px;outline-color:#bdbdbd;height:40px;line-height:40px;text-decoration:none;background-color:transparent;cursor:pointer;font-size:13px;font-family:Helvetica,Arial,sans-serif}.phylocanvas-context-menu li:focus,.phylocanvas-context-menu li:hover{background-color:#eee}.phylocanvas-context-menu a{display:block;margin:0 -16px;padding:0 16px}.phylocanvas-context-menu a,.phylocanvas-context-menu li{color:rgba(0,0,0,.87);text-decoration:none;white-space:nowrap}", ""])
            }, function(t, e) {
                "use strict";
                t.exports = function() {
                    var t = [];
                    return t.toString = function() {
                        for (var t = [], e = 0; e < this.length; e++) {
                            var n = this[e];
                            n[2] ? t.push("@media " + n[2] + "{" + n[1] + "}") : t.push(n[1])
                        }
                        return t.join("")
                    }, t.i = function(e, n) {
                        "string" == typeof e && (e = [
                            [null, e, ""]
                        ]);
                        for (var r = {}, a = 0; a < this.length; a++) {
                            var i = this[a][0];
                            "number" == typeof i && (r[i] = !0)
                        }
                        for (a = 0; a < e.length; a++) {
                            var o = e[a];
                            "number" == typeof o[0] && r[o[0]] || (n && !o[2] ? o[2] = n : n && (o[2] = "(" + o[2] + ") and (" + n + ")"), t.push(o))
                        }
                    }, t
                }
            }, function(t, e, n) {
                function r(t, e) {
                    for (var n = 0; n < t.length; n++) {
                        var r = t[n],
                            a = d[r.id];
                        if (a) {
                            a.refs++;
                            for (var i = 0; i < a.parts.length; i++) a.parts[i](r.parts[i]);
                            for (; i < r.parts.length; i++) a.parts.push(c(r.parts[i], e))
                        } else {
                            for (var o = [], i = 0; i < r.parts.length; i++) o.push(c(r.parts[i], e));
                            d[r.id] = {
                                id: r.id,
                                refs: 1,
                                parts: o
                            }
                        }
                    }
                }

                function a(t) {
                    for (var e = [], n = {}, r = 0; r < t.length; r++) {
                        var a = t[r],
                            i = a[0],
                            o = a[1],
                            s = a[2],
                            l = a[3],
                            c = {
                                css: o,
                                media: s,
                                sourceMap: l
                            };
                        n[i] ? n[i].parts.push(c) : e.push(n[i] = {
                            id: i,
                            parts: [c]
                        })
                    }
                    return e
                }

                function i(t, e) {
                    var n = p(),
                        r = b[b.length - 1];
                    if ("top" === t.insertAt) r ? r.nextSibling ? n.insertBefore(e, r.nextSibling) : n.appendChild(e) : n.insertBefore(e, n.firstChild), b.push(e);
                    else {
                        if ("bottom" !== t.insertAt) throw new Error("Invalid value for parameter 'insertAt'. Must be 'top' or 'bottom'.");
                        n.appendChild(e)
                    }
                }

                function o(t) {
                    t.parentNode.removeChild(t);
                    var e = b.indexOf(t);
                    e >= 0 && b.splice(e, 1)
                }

                function s(t) {
                    var e = document.createElement("style");
                    return e.type = "text/css", i(t, e), e
                }

                function l(t) {
                    var e = document.createElement("link");
                    return e.rel = "stylesheet", i(t, e), e
                }

                function c(t, e) {
                    var n, r, a;
                    if (e.singleton) {
                        var i = y++;
                        n = g || (g = s(e)), r = h.bind(null, n, i, !1), a = h.bind(null, n, i, !0)
                    } else t.sourceMap && "function" == typeof URL && "function" == typeof URL.createObjectURL && "function" == typeof URL.revokeObjectURL && "function" == typeof Blob && "function" == typeof btoa ? (n = l(e), r = f.bind(null, n), a = function() {
                        o(n), n.href && URL.revokeObjectURL(n.href)
                    }) : (n = s(e), r = u.bind(null, n), a = function() {
                        o(n)
                    });
                    return r(t),
                        function(e) {
                            if (e) {
                                if (e.css === t.css && e.media === t.media && e.sourceMap === t.sourceMap) return;
                                r(t = e)
                            } else a()
                        }
                }

                function h(t, e, n, r) {
                    var a = n ? "" : r.css;
                    if (t.styleSheet) t.styleSheet.cssText = m(e, a);
                    else {
                        var i = document.createTextNode(a),
                            o = t.childNodes;
                        o[e] && t.removeChild(o[e]), o.length ? t.insertBefore(i, o[e]) : t.appendChild(i)
                    }
                }

                function u(t, e) {
                    var n = e.css,
                        r = e.media;
                    if (r && t.setAttribute("media", r), t.styleSheet) t.styleSheet.cssText = n;
                    else {
                        for (; t.firstChild;) t.removeChild(t.firstChild);
                        t.appendChild(document.createTextNode(n))
                    }
                }

                function f(t, e) {
                    var n = e.css,
                        r = e.sourceMap;
                    r && (n += "\n/*# sourceMappingURL=data:application/json;base64," + btoa(unescape(encodeURIComponent(JSON.stringify(r)))) + " */");
                    var a = new Blob([n], {
                            type: "text/css"
                        }),
                        i = t.href;
                    t.href = URL.createObjectURL(a), i && URL.revokeObjectURL(i)
                }
                var d = {},
                    C = function(t) {
                        var e;
                        return function() {
                            return "undefined" == typeof e && (e = t.apply(this, arguments)), e
                        }
                    },
                    v = C(function() {
                        return /msie [6-9]\b/.test(window.navigator.userAgent.toLowerCase())
                    }),
                    p = C(function() {
                        return document.head || document.getElementsByTagName("head")[0]
                    }),
                    g = null,
                    y = 0,
                    b = [];
                t.exports = function(t, e) {
                    e = e || {}, "undefined" == typeof e.singleton && (e.singleton = v()), "undefined" == typeof e.insertAt && (e.insertAt = "bottom");
                    var n = a(t);
                    return r(n, e),
                        function(t) {
                            for (var i = [], o = 0; o < n.length; o++) {
                                var s = n[o],
                                    l = d[s.id];
                                l.refs--, i.push(l)
                            }
                            if (t) {
                                var c = a(t);
                                r(c, e)
                            }
                            for (var o = 0; o < i.length; o++) {
                                var l = i[o];
                                if (0 === l.refs) {
                                    for (var h = 0; h < l.parts.length; h++) l.parts[h]();
                                    delete d[l.id]
                                }
                            }
                        }
                };
                var m = function() {
                    var t = [];
                    return function(e, n) {
                        return t[e] = n, t.filter(Boolean).join("\n")
                    }
                }()
            }])
        })
    }, function(t, e, n) {
        ! function(e, r) {
            t.exports = r(n(3))
        }(this, function(t) {
            return function(t) {
                function e(r) {
                    if (n[r]) return n[r].exports;
                    var a = n[r] = {
                        exports: {},
                        id: r,
                        loaded: !1
                    };
                    return t[r].call(a.exports, a, a.exports, e), a.loaded = !0, a.exports
                }
                var n = {};
                return e.m = t, e.c = n, e.p = "", e(0)
            }([function(t, e, n) {
                "use strict";

                function r(t) {
                    if (Array.isArray(t)) {
                        for (var e = 0, n = Array(t.length); e < t.length; e++) n[e] = t[e];
                        return n
                    }
                    return Array.from(t)
                }

                function a() {
                    var t = this.scalebar,
                        e = this.zoom,
                        n = this.branchScalar,
                        r = t.width,
                        a = t.height,
                        i = t.position,
                        o = t.lineWidth,
                        s = this.canvas,
                        l = s.canvas;
                    s.save();
                    var f = 0;
                    "undefined" != typeof i.left ? f = t.lineWidth + i.left : "undefined" != typeof i.centre ? f = l.width / 2 - r / 2 + i.centre : "undefined" != typeof i.right ? f = l.width - r - t.lineWidth - i.right : this.loadError(c);
                    var d = 0;
                    "undefined" != typeof i.top ? d = i.top : "undefined" != typeof i.middle ? d = l.height / 2 - a + i.middle : "undefined" != typeof i.bottom ? d = l.height - a - i.bottom : this.loadError(h), s.clearRect(f, d, r, a), s.font = t.font, s.fillStyle = t.fillStyle, s.strokeStyle = t.strokeStyle, s.lineWidth = o, s.textBaseline = t.textBaseline, s.textAlign = t.textAlign, s.beginPath(), s.moveTo(f, d), s.lineTo(f + r, d), s.stroke(), s.moveTo(f, d), s.lineTo(f, d + a), s.stroke(), s.moveTo(f + r, d), s.lineTo(f + r, d + a), s.stroke(), s.closePath();
                    var C = r / n / e,
                        v = parseInt(Math.abs(Math.log(C) / u), 10),
                        p = C.toFixed(v + t.digits);
                    s.fillText(p, f + r / 2, d + a), s.restore()
                }

                function i(t) {
                    t(this, "createTree", function(t, e) {
                        var n = t.apply(void 0, r(e)),
                            a = o(e, 2),
                            i = a[1],
                            s = void 0 === i ? {} : i;
                        return n.scalebar = Object.assign({}, l, s.scalebar || {}), n
                    }), t(s.Tree, "draw", function(t, e) {
                        t.apply(this, e), this.scalebar.active && a.apply(this)
                    })
                }
                Object.defineProperty(e, "__esModule", {
                    value: !0
                });
                var o = function() {
                    function t(t, e) {
                        var n = [],
                            r = !0,
                            a = !1,
                            i = void 0;
                        try {
                            for (var o, s = t[Symbol.iterator](); !(r = (o = s.next()).done) && (n.push(o.value), !e || n.length !== e); r = !0);
                        } catch (t) {
                            a = !0, i = t
                        } finally {
                            try {
                                !r && s.return && s.return()
                            } finally {
                                if (a) throw i
                            }
                        }
                        return n
                    }
                    return function(e, n) {
                        if (Array.isArray(e)) return e;
                        if (Symbol.iterator in Object(e)) return t(e, n);
                        throw new TypeError("Invalid attempt to destructure non-iterable instance")
                    }
                }();
                e.default = i;
                var s = n(1),
                    l = {
                        active: !0,
                        width: 100,
                        height: 20,
                        fillStyle: "black",
                        strokeStyle: "black",
                        lineWidth: 1,
                        font: "16px Sans-serif",
                        textBaseline: "bottom",
                        textAlign: "center",
                        digits: 2,
                        position: {
                            bottom: 10,
                            left: 10
                        }
                    },
                    c = "Invalid horizontal position specifiedSupported values are `left`, `centre`, or `right`",
                    h = "Invalid vertical position specifiedSupported values are `top`, `middle`, or `bottom`",
                    u = Math.log(10)
            }, function(e, n) {
                e.exports = t
            }])
        })
    }])
});