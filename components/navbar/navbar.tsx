import './navbar.css';
import React from 'react';
import Link from 'next/link'

export interface NavbarProps {
    className?: string;
}

export const Navbar: React.FC<NavbarProps> = ({ className = '' }) => (<nav className="nav">
    <p className="navbartitle"><Link href="/">B AIRWAYS</Link></p>
    <div className="Links">
        <span>SEARCH</span>
        <span>ABOUT US</span></div>
    <div className="navbuttons">
        <Link href="/login"><button disabled={false} className="button">LOGIN</button></Link>
        <Link href="/register"><button className="button buttonHover">REGISTER</button></Link>
    </div>
</nav>
);