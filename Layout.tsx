import { Link } from 'react-router-dom'
import type { ReactNode } from 'react'

export function Layout({ title, subtitle, actions, children }: { title: string; subtitle: string; actions?: ReactNode; children: ReactNode }) {
  return (
    <div className="appShell">
      <header className="topbar">
        <div>
          <div className="eyebrow">ReconFlow B • realtime MVP</div>
          <h1>{title}</h1>
          <p className="subtitle">{subtitle}</p>
        </div>
        <nav className="navLinks">
          <Link to="/">Дашборд</Link>
          <Link to="/join">QR-страница</Link>
          <Link to="/control">Панель ведущего</Link>
        </nav>
        {actions}
      </header>
      <main>{children}</main>
    </div>
  )
}
